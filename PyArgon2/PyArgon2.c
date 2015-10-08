#include <string.h>
#include <Python.h>
#include <argon2.h>

struct module_state {
  PyObject *error;
};

#if PY_MAJOR_VERSION >= 3
 #define GETSTATE(m) ((struct module_state*)PyModule_GetState(m))
#else
 #define GETSTATE(m) (&_state)
static struct module_state _state;
#endif


static PyObject *Hash_pwd(PyObject *self, PyObject *args)
{
  char	hash[64] = {0};
  PyObject *py_pwd = PyTuple_GetItem(args, 0);
  PyObject *py_salt = PyTuple_GetItem(args, 1);
  ssize_t size_pwd = PyBytes_Size(py_pwd);
  ssize_t size_salt = PyBytes_Size(py_salt);
  char	*pwd = PyBytes_AsString(py_pwd);
  char	*salt = PyBytes_AsString(py_salt);
  int err;
  const char *ret;

  Argon2_Context arg_ctx = {(uint8_t*)hash, 64, (uint8_t*)pwd, size_pwd, (uint8_t*)salt, size_salt, NULL, 0, NULL, 0, 5, 2 << 9, 4, 1, NULL, NULL, false, false, false};

  if ((err = Argon2d(&arg_ctx)) != ARGON2_OK)
    ret = ErrorMessage(err);
  else
    ret = hash;

  return Py_BuildValue("y", ret);
}


static PyObject *Check_pwd(PyObject *self, PyObject *args)
{
  char	hash[64] = {0};
  PyObject *py_pwd = PyTuple_GetItem(args, 0);
  PyObject *py_salt = PyTuple_GetItem(args, 1);
  PyObject *py_hash_check = PyTuple_GetItem(args, 2);
  ssize_t size_pwd = PyBytes_Size(py_pwd);
  ssize_t size_salt = PyBytes_Size(py_salt);
  char	*pwd = PyBytes_AsString(py_pwd);
  char	*salt = PyBytes_AsString(py_salt);
  char	*hash_check = PyBytes_AsString(py_hash_check);
  PyObject *ret;
  
  Argon2_Context arg_ctx = {(uint8_t*)hash, 64, (uint8_t*)pwd, size_pwd, (uint8_t*)salt, size_salt, NULL, 0, NULL, 0, 5, 2 << 9, 4, 1, NULL, NULL, false, false, false};

  if (VerifyD(&arg_ctx, (char *)hash_check))
    ret = Py_True;
  else
    ret = Py_False;

  return ret;
}

static PyMethodDef PyArgon2_methods[] = {
  {"Hash_pwd", (PyCFunction)Hash_pwd, METH_VARARGS, NULL},
  {"Check_pwd", (PyCFunction)Check_pwd, METH_VARARGS, NULL},
  {NULL, NULL, 0, NULL}
};

#if PY_MAJOR_VERSION >= 3

static int PyArgon2_traverse(PyObject *m, visitproc visit, void *arg)
{
  Py_VISIT(GETSTATE(m)->error);
  return 0;
}

static int PyArgon2_clear(PyObject *m)
{
  Py_CLEAR(GETSTATE(m)->error);
  return 0;
}


static struct PyModuleDef moduledef = {
  PyModuleDef_HEAD_INIT,
  "PyArgon2",
  NULL,
  sizeof(struct module_state),
  PyArgon2_methods,
  NULL,
  PyArgon2_traverse,
  PyArgon2_clear,
  NULL};

 #define INITERROR return NULL

PyObject *PyInit_PyArgon2(void)
#else
 #define INITERROR return

void initPyArgon2()
#endif

{
#if PY_MAJOR_VERSION >= 3
  PyObject *module = PyModule_Create(&moduledef);
#else
  PyObject *module = Py_InitModule("PyArgon2", PyArgon2_methods, "Python binding for the C Argon2 library");
#endif

  if (!module)
    INITERROR;

  struct module_state *st = GETSTATE(module);

  st->error = PyErr_NewException("myextension.Error", NULL, NULL);
  if (st->error == NULL) {
    Py_DECREF(module);
    INITERROR;
  }

#if PY_MAJOR_VERSION >= 3
  return module;
#endif
}
