from distutils.core import setup, Extension


setup(name='PyArgon2', version='1.0',
      ext_modules=[Extension('PyArgon2',
                             sources = ['PyArgon2.c'],
                             library_dirs=['/usr/lib', '.'],
                             libraries=['argon2'],
                             include_dirs=['.'])])
