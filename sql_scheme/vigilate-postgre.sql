--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dealer; Type: TABLE; Schema: public; Owner: vigilate; Tablespace: 
--

CREATE TABLE dealer (
    id integer NOT NULL,
    id_user_dealer integer NOT NULL,
    id_user_client integer NOT NULL
);


ALTER TABLE public.dealer OWNER TO vigilate;

--
-- Name: dealer_id_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE dealer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dealer_id_seq OWNER TO vigilate;

--
-- Name: dealer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE dealer_id_seq OWNED BY dealer.id;


--
-- Name: dealer_id_user_client_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE dealer_id_user_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dealer_id_user_client_seq OWNER TO vigilate;

--
-- Name: dealer_id_user_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE dealer_id_user_client_seq OWNED BY dealer.id_user_client;


--
-- Name: dealer_id_user_dealer_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE dealer_id_user_dealer_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dealer_id_user_dealer_seq OWNER TO vigilate;

--
-- Name: dealer_id_user_dealer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE dealer_id_user_dealer_seq OWNED BY dealer.id_user_dealer;


--
-- Name: user_monitored_program; Type: TABLE; Schema: public; Owner: vigilate; Tablespace: 
--

CREATE TABLE user_monitored_program (
    id integer NOT NULL,
    program_name character varying(20),
    program_version character varying(20),
    minimum_score smallint
);


ALTER TABLE public.user_monitored_program OWNER TO vigilate;

--
-- Name: user_monitored_program_id_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE user_monitored_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_monitored_program_id_seq OWNER TO vigilate;

--
-- Name: user_monitored_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE user_monitored_program_id_seq OWNED BY user_monitored_program.id;


--
-- Name: user_preference; Type: TABLE; Schema: public; Owner: vigilate; Tablespace: 
--

CREATE TABLE user_preference (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_program integer NOT NULL,
    score smallint,
    alert_mean smallint
);


ALTER TABLE public.user_preference OWNER TO vigilate;

--
-- Name: user_preference_id_program_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE user_preference_id_program_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_preference_id_program_seq OWNER TO vigilate;

--
-- Name: user_preference_id_program_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE user_preference_id_program_seq OWNED BY user_preference.id_program;


--
-- Name: user_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE user_preference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_preference_id_seq OWNER TO vigilate;

--
-- Name: user_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE user_preference_id_seq OWNED BY user_preference.id;


--
-- Name: user_preference_id_user_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE user_preference_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_preference_id_user_seq OWNER TO vigilate;

--
-- Name: user_preference_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE user_preference_id_user_seq OWNED BY user_preference.id_user;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vigilate; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(20),
    email character varying(100),
    password character varying(60),
    id_list_programs_monitored integer NOT NULL,
    id_preference integer NOT NULL,
    type smallint,
    contrat smallint
);


ALTER TABLE public.users OWNER TO vigilate;

--
-- Name: users_id_list_programs_monitored_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE users_id_list_programs_monitored_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_list_programs_monitored_seq OWNER TO vigilate;

--
-- Name: users_id_list_programs_monitored_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE users_id_list_programs_monitored_seq OWNED BY users.id_list_programs_monitored;


--
-- Name: users_id_preference_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE users_id_preference_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_preference_seq OWNER TO vigilate;

--
-- Name: users_id_preference_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE users_id_preference_seq OWNED BY users.id_preference;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO vigilate;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: vulns; Type: TABLE; Schema: public; Owner: vigilate; Tablespace: 
--

CREATE TABLE vulns (
    id integer NOT NULL,
    cveid character varying(20),
    program_name character varying(20),
    program_version character varying(20),
    date date,
    detail text,
    simplified_detail text,
    score smallint
);


ALTER TABLE public.vulns OWNER TO vigilate;

--
-- Name: vulns_id_seq; Type: SEQUENCE; Schema: public; Owner: vigilate
--

CREATE SEQUENCE vulns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vulns_id_seq OWNER TO vigilate;

--
-- Name: vulns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vigilate
--

ALTER SEQUENCE vulns_id_seq OWNED BY vulns.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY dealer ALTER COLUMN id SET DEFAULT nextval('dealer_id_seq'::regclass);


--
-- Name: id_user_dealer; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY dealer ALTER COLUMN id_user_dealer SET DEFAULT nextval('dealer_id_user_dealer_seq'::regclass);


--
-- Name: id_user_client; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY dealer ALTER COLUMN id_user_client SET DEFAULT nextval('dealer_id_user_client_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY user_monitored_program ALTER COLUMN id SET DEFAULT nextval('user_monitored_program_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY user_preference ALTER COLUMN id SET DEFAULT nextval('user_preference_id_seq'::regclass);


--
-- Name: id_user; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY user_preference ALTER COLUMN id_user SET DEFAULT nextval('user_preference_id_user_seq'::regclass);


--
-- Name: id_program; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY user_preference ALTER COLUMN id_program SET DEFAULT nextval('user_preference_id_program_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id_list_programs_monitored; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY users ALTER COLUMN id_list_programs_monitored SET DEFAULT nextval('users_id_list_programs_monitored_seq'::regclass);


--
-- Name: id_preference; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY users ALTER COLUMN id_preference SET DEFAULT nextval('users_id_preference_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vigilate
--

ALTER TABLE ONLY vulns ALTER COLUMN id SET DEFAULT nextval('vulns_id_seq'::regclass);


--
-- Name: dealer_pkey; Type: CONSTRAINT; Schema: public; Owner: vigilate; Tablespace: 
--

ALTER TABLE ONLY dealer
    ADD CONSTRAINT dealer_pkey PRIMARY KEY (id);


--
-- Name: user_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: vigilate; Tablespace: 
--

ALTER TABLE ONLY user_preference
    ADD CONSTRAINT user_preference_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vigilate; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

