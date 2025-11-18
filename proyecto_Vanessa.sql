--
-- PostgreSQL database dump
--

\restrict YZGG7xMCPWF0jzXSF2jJsMU3Io9Mwn666UYVMHPL3DwUrCJmF4tv9GEBEh0ylKw

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_cuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_cuenta (
    id_cuenta integer NOT NULL,
    nombre_cuenta character varying(100) NOT NULL
);


ALTER TABLE public.dim_cuenta OWNER TO postgres;

--
-- Name: dim_cuenta_id_cuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_cuenta_id_cuenta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_cuenta_id_cuenta_seq OWNER TO postgres;

--
-- Name: dim_cuenta_id_cuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_cuenta_id_cuenta_seq OWNED BY public.dim_cuenta.id_cuenta;


--
-- Name: dim_meta_subcuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_meta_subcuenta (
    id_meta integer NOT NULL,
    id_subcuenta integer NOT NULL,
    metrica character varying(50) NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    objetivo numeric NOT NULL
);


ALTER TABLE public.dim_meta_subcuenta OWNER TO postgres;

--
-- Name: dim_meta_subcuenta_id_meta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_meta_subcuenta_id_meta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_meta_subcuenta_id_meta_seq OWNER TO postgres;

--
-- Name: dim_meta_subcuenta_id_meta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_meta_subcuenta_id_meta_seq OWNED BY public.dim_meta_subcuenta.id_meta;


--
-- Name: dim_subcuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_subcuenta (
    id_subcuenta integer NOT NULL,
    id_cuenta integer NOT NULL,
    nombre_subcuenta character varying(100) NOT NULL
);


ALTER TABLE public.dim_subcuenta OWNER TO postgres;

--
-- Name: dim_subcuenta_id_subcuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_subcuenta_id_subcuenta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_subcuenta_id_subcuenta_seq OWNER TO postgres;

--
-- Name: dim_subcuenta_id_subcuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_subcuenta_id_subcuenta_seq OWNED BY public.dim_subcuenta.id_subcuenta;


--
-- Name: dim_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_usuario (
    id_usuario integer NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    password_hash character varying(50) NOT NULL,
    rol character varying(20) DEFAULT 'viewer'::character varying,
    activo boolean DEFAULT true
);


ALTER TABLE public.dim_usuario OWNER TO postgres;

--
-- Name: dim_usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_usuario_id_usuario_seq OWNER TO postgres;

--
-- Name: dim_usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_usuario_id_usuario_seq OWNED BY public.dim_usuario.id_usuario;


--
-- Name: fact_channel_daily_metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_channel_daily_metrics (
    date date NOT NULL,
    views_total bigint DEFAULT 0,
    watch_time bigint DEFAULT 0,
    revenue numeric(10,2) DEFAULT 0,
    subscribers integer DEFAULT 0,
    impressions bigint DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    id_subcuenta integer NOT NULL
);


ALTER TABLE public.fact_channel_daily_metrics OWNER TO postgres;

--
-- Name: fact_video_weekly_metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_video_weekly_metrics (
    video_id character varying(20) NOT NULL,
    video_title text,
    week integer NOT NULL,
    year integer NOT NULL,
    views bigint DEFAULT 0,
    watch_time bigint DEFAULT 0,
    revenue numeric(10,2) DEFAULT 0,
    subscribers integer DEFAULT 0,
    impressions bigint DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    id_subcuenta integer NOT NULL
);


ALTER TABLE public.fact_video_weekly_metrics OWNER TO postgres;

--
-- Name: usuario_subcuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_subcuenta (
    id_usuario integer NOT NULL,
    id_subcuenta integer NOT NULL
);


ALTER TABLE public.usuario_subcuenta OWNER TO postgres;

--
-- Name: dim_cuenta id_cuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cuenta ALTER COLUMN id_cuenta SET DEFAULT nextval('public.dim_cuenta_id_cuenta_seq'::regclass);


--
-- Name: dim_meta_subcuenta id_meta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_meta_subcuenta ALTER COLUMN id_meta SET DEFAULT nextval('public.dim_meta_subcuenta_id_meta_seq'::regclass);


--
-- Name: dim_subcuenta id_subcuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_subcuenta ALTER COLUMN id_subcuenta SET DEFAULT nextval('public.dim_subcuenta_id_subcuenta_seq'::regclass);


--
-- Name: dim_usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.dim_usuario_id_usuario_seq'::regclass);


--
-- Data for Name: dim_cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_cuenta (id_cuenta, nombre_cuenta) FROM stdin;
1	Vanessa
2	Administrador
\.


--
-- Data for Name: dim_meta_subcuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_meta_subcuenta (id_meta, id_subcuenta, metrica, mes, anio, objetivo) FROM stdin;
1	1	views	1	2025	29108
2	1	views	2	2025	30237
3	1	views	3	2025	399910
4	1	views	4	2025	54209
5	1	views	5	2025	77448
6	1	views	6	2025	39312
7	1	views	7	2025	92232
8	1	views	8	2025	59564
9	1	views	9	2025	59436
10	1	views	10	2025	46286
11	1	views	11	2025	49212
12	1	views	12	2025	50212
\.


--
-- Data for Name: dim_subcuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_subcuenta (id_subcuenta, id_cuenta, nombre_subcuenta) FROM stdin;
1	1	VanessaNavarro
2	2	Administrador
\.


--
-- Data for Name: dim_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_usuario (id_usuario, nombre_usuario, password_hash, rol, activo) FROM stdin;
1	VanessaNavarro	1728	viewer	t
2	Administrador	5512	admin	t
\.


--
-- Data for Name: fact_channel_daily_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_channel_daily_metrics (date, views_total, watch_time, revenue, subscribers, impressions, created_at, id_subcuenta) FROM stdin;
2025-01-01	115	3	0.00	2	0	2025-11-14 15:27:04.002726	1
2025-01-02	164	4	0.00	7	0	2025-11-14 15:27:04.002726	1
2025-01-03	130	3	0.00	6	0	2025-11-14 15:27:04.002726	1
2025-01-04	470	6	0.00	5	0	2025-11-14 15:27:04.002726	1
2025-01-05	821	13	0.00	18	0	2025-11-14 15:27:04.002726	1
2025-01-06	226	5	0.00	14	0	2025-11-14 15:35:08.137271	1
2025-01-07	485	8	0.00	8	0	2025-11-14 15:35:08.137271	1
2025-01-08	749	13	0.00	12	0	2025-11-14 15:35:08.137271	1
2025-01-09	709	13	0.00	7	0	2025-11-14 15:35:08.137271	1
2025-01-10	592	10	0.00	4	0	2025-11-14 15:35:08.137271	1
2025-01-11	257	5	0.00	2	0	2025-11-14 15:35:08.137271	1
2025-01-13	389	7	0.00	2	0	2025-11-15 09:31:02.055735	1
2025-01-14	612	10	0.00	6	0	2025-11-15 09:31:02.055735	1
2025-01-15	1103	17	0.00	13	0	2025-11-15 09:31:02.055735	1
2025-01-16	994	16	0.00	7	0	2025-11-15 09:31:02.055735	1
2025-01-17	704	10	0.00	10	0	2025-11-15 09:31:02.055735	1
2025-01-18	586	9	0.00	5	0	2025-11-15 09:31:02.055735	1
2025-01-19	212	4	0.00	2	0	2025-11-15 09:31:02.055735	1
2025-01-20	252	5	0.00	4	0	2025-11-15 09:31:53.629514	1
2025-01-21	373	7	0.00	6	0	2025-11-15 09:31:53.629514	1
2025-01-22	164	3	0.00	2	0	2025-11-15 09:31:53.629514	1
2025-01-23	271	5	0.00	5	0	2025-11-15 09:31:53.629514	1
2025-01-24	157	4	0.00	3	0	2025-11-15 09:31:53.629514	1
2025-01-25	203	4	0.00	4	0	2025-11-15 09:31:53.629514	1
2025-01-26	128	3	0.00	5	0	2025-11-15 09:31:53.629514	1
2025-01-27	312	5	0.00	3	0	2025-11-15 09:33:16.926343	1
2025-01-28	473	10	0.00	4	0	2025-11-15 09:33:16.926343	1
2025-01-29	807	13	0.00	4	0	2025-11-15 09:33:16.926343	1
2025-01-30	158	3	0.00	2	0	2025-11-15 09:33:16.926343	1
2025-01-31	160	4	0.00	2	0	2025-11-15 09:33:16.926343	1
2025-02-01	181	4	0.00	4	0	2025-11-15 09:33:16.926343	1
2025-02-02	214	4	0.00	7	0	2025-11-15 09:33:16.926343	1
2025-02-03	295	5	0.00	0	0	2025-11-15 09:50:39.635692	1
2025-02-04	258	6	0.00	4	0	2025-11-15 09:50:39.635692	1
2025-02-05	272	6	0.00	2	0	2025-11-15 09:50:39.635692	1
2025-02-06	308	7	0.00	0	0	2025-11-15 09:50:39.635692	1
2025-02-07	270	6	0.00	1	0	2025-11-15 09:50:39.635692	1
2025-02-08	231	5	0.00	19	0	2025-11-15 09:50:39.635692	1
2025-02-09	257	6	0.00	11	0	2025-11-15 09:50:39.635692	1
2025-02-10	280	6	0.00	5	0	2025-11-15 09:51:19.387769	1
2025-02-11	271	6	0.00	5	0	2025-11-15 09:51:19.387769	1
2025-02-12	279	6	0.00	0	0	2025-11-15 09:51:19.387769	1
2025-02-13	480	9	0.00	7	0	2025-11-15 09:51:19.387769	1
2025-02-14	762	14	0.00	4	0	2025-11-15 09:51:19.387769	1
2025-02-15	695	11	0.00	6	0	2025-11-15 09:51:19.387769	1
2025-02-16	643	12	0.00	13	0	2025-11-15 09:51:19.387769	1
2025-02-17	433	9	0.00	14	0	2025-11-15 09:51:59.614245	1
2025-02-18	516	9	0.00	4	0	2025-11-15 09:51:59.614245	1
2025-02-19	701	13	0.00	1	0	2025-11-15 09:51:59.614245	1
2025-02-20	817	15	0.00	9	0	2025-11-15 09:51:59.614245	1
2025-02-21	1012	16	0.00	16	0	2025-11-15 09:51:59.614245	1
2025-02-22	688	10	0.00	12	0	2025-11-15 09:51:59.614245	1
2025-02-23	907	13	0.00	13	0	2025-11-15 09:51:59.614245	1
2025-02-24	1045	16	0.00	10	0	2025-11-15 09:53:18.044348	1
2025-02-25	398	8	0.00	7	0	2025-11-15 09:53:18.044348	1
2025-02-26	822	14	0.00	5	0	2025-11-15 09:53:18.044348	1
2025-02-27	633	13	0.00	3	0	2025-11-15 09:53:18.044348	1
2025-02-28	331	6	0.00	1	0	2025-11-15 09:53:18.044348	1
2025-03-01	627	15	0.00	10	0	2025-11-15 09:53:18.044348	1
2025-03-02	547	12	0.00	6	0	2025-11-15 09:53:18.044348	1
2025-03-03	438	8	0.00	0	0	2025-11-15 10:27:36.768469	1
2025-03-04	726	14	0.00	6	0	2025-11-15 10:27:36.768469	1
2025-03-05	500	9	0.00	6	0	2025-11-15 10:27:36.768469	1
2025-03-06	355	7	0.00	-1	0	2025-11-15 10:27:36.768469	1
2025-03-07	334	7	0.00	2	0	2025-11-15 10:27:36.768469	1
2025-03-08	270	5	0.00	1	0	2025-11-15 10:27:36.768469	1
2025-03-09	395	8	0.00	2	0	2025-11-15 10:27:36.768469	1
2025-03-10	346	8	0.00	2	0	2025-11-15 10:28:10.510213	1
2025-03-11	354	8	0.00	-1	0	2025-11-15 10:28:10.510213	1
2025-03-12	407	8	0.00	4	0	2025-11-15 10:28:10.510213	1
2025-03-13	428	10	0.00	1	0	2025-11-15 10:28:10.510213	1
2025-03-14	413	9	0.00	5	0	2025-11-15 10:28:10.510213	1
2025-03-15	393	9	0.00	9	0	2025-11-15 10:28:10.510213	1
2025-03-16	851	13	0.00	5	0	2025-11-15 10:28:10.510213	1
2025-03-17	511	11	0.00	3	0	2025-11-15 10:28:49.013947	1
2025-03-18	417	9	0.00	7	0	2025-11-15 10:28:49.013947	1
2025-03-19	324	8	0.00	4	0	2025-11-15 10:28:49.013947	1
2025-03-20	395	9	0.00	3	0	2025-11-15 10:28:49.013947	1
2025-03-21	322	8	0.00	1	0	2025-11-15 10:28:49.013947	1
2025-03-22	530	11	0.00	38	0	2025-11-15 10:28:49.013947	1
2025-03-23	1875	29	0.00	91	0	2025-11-15 10:28:49.013947	1
2025-03-24	824	15	0.00	18	0	2025-11-15 10:29:22.52353	1
2025-03-25	1151	19	0.00	18	0	2025-11-15 10:29:22.52353	1
2025-03-26	704	13	0.00	15	0	2025-11-15 10:29:22.52353	1
2025-03-27	602	14	0.00	8	0	2025-11-15 10:29:22.52353	1
2025-03-28	416	9	0.00	4	0	2025-11-15 10:29:22.52353	1
2025-03-29	541	13	0.00	9	0	2025-11-15 10:29:22.52353	1
2025-03-30	836	17	0.00	9	0	2025-11-15 10:29:22.52353	1
2025-03-31	1645	21	0.00	6	0	2025-11-15 10:30:57.82785	1
2025-04-01	987	13	0.00	8	0	2025-11-15 10:30:57.82785	1
2025-04-02	886	13	0.00	6	0	2025-11-15 10:30:57.82785	1
2025-04-03	711	10	0.00	3	0	2025-11-15 10:30:57.82785	1
2025-04-04	629	10	0.00	8	0	2025-11-15 10:30:57.82785	1
2025-04-05	547	9	0.00	4	0	2025-11-15 10:30:57.82785	1
2025-04-06	960	13	0.00	10	0	2025-11-15 10:30:57.82785	1
2025-04-07	668	11	0.00	4	0	2025-11-15 10:31:54.064924	1
2025-04-08	818	14	0.00	7	0	2025-11-15 10:31:54.064924	1
2025-04-09	862	16	0.00	12	0	2025-11-15 10:31:54.064924	1
2025-04-10	1076	16	0.00	10	0	2025-11-15 10:31:54.064924	1
2025-04-11	1253	14	0.00	4	0	2025-11-15 10:31:54.064924	1
2025-04-12	1412	16	0.00	8	0	2025-11-15 10:31:54.064924	1
2025-04-13	608	9	0.00	7	0	2025-11-15 10:31:54.064924	1
2025-04-14	636	10	0.00	4	0	2025-11-15 10:32:26.5002	1
2025-04-15	907	14	0.00	14	0	2025-11-15 10:32:26.5002	1
2025-04-16	573	9	0.00	9	0	2025-11-15 10:32:26.5002	1
2025-04-17	557	8	0.00	4	0	2025-11-15 10:32:26.5002	1
2025-04-18	435	7	0.00	8	0	2025-11-15 10:32:26.5002	1
2025-04-19	667	14	0.00	11	0	2025-11-15 10:32:26.5002	1
2025-04-20	679	12	0.00	6	0	2025-11-15 10:32:26.5002	1
2025-04-21	1024	16	0.00	21	0	2025-11-15 10:33:02.220039	1
2025-04-22	1191	17	0.00	25	0	2025-11-15 10:33:02.220039	1
2025-04-23	1101	15	0.00	27	0	2025-11-15 10:33:02.220039	1
2025-04-24	972	15	0.00	20	0	2025-11-15 10:33:02.220039	1
2025-04-25	944	11	0.00	7	0	2025-11-15 10:33:02.220039	1
2025-04-26	735	11	0.00	4	0	2025-11-15 10:33:02.220039	1
2025-04-27	1010	13	0.00	6	0	2025-11-15 10:33:02.220039	1
2025-04-28	908	12	0.00	10	0	2025-11-15 10:34:06.633653	1
2025-04-29	617	9	0.00	5	0	2025-11-15 10:34:06.633653	1
2025-04-30	724	11	0.00	5	0	2025-11-15 10:34:06.633653	1
2025-05-01	722	12	0.00	5	0	2025-11-15 10:34:06.633653	1
2025-05-02	532	9	0.00	3	0	2025-11-15 10:34:06.633653	1
2025-05-03	639	9	0.00	7	0	2025-11-15 10:34:06.633653	1
2025-05-04	699	11	0.00	3	0	2025-11-15 10:34:06.633653	1
2025-05-05	631	9	0.00	2	0	2025-11-15 10:47:28.506867	1
2025-05-06	588	8	0.00	4	0	2025-11-15 10:47:28.506867	1
2025-05-07	472	6	0.00	8	0	2025-11-15 10:47:28.506867	1
2025-05-08	430	7	0.00	2	0	2025-11-15 10:47:28.506867	1
2025-05-09	324	4	0.00	3	0	2025-11-15 10:47:28.506867	1
2025-05-10	230	3	0.00	2	0	2025-11-15 10:47:28.506867	1
2025-05-11	609	8	0.00	4	0	2025-11-15 10:47:28.506867	1
2025-05-12	3351	18	0.00	7	0	2025-11-15 10:48:15.695426	1
2025-05-13	2822	20	0.00	16	0	2025-11-15 10:48:15.695426	1
2025-05-14	6714	45	0.00	18	0	2025-11-15 10:48:15.695426	1
2025-05-15	5449	38	0.00	36	0	2025-11-15 10:48:15.695426	1
2025-05-16	1343	11	0.00	9	0	2025-11-15 10:48:15.695426	1
2025-05-17	463	5	0.00	0	0	2025-11-15 10:48:15.695426	1
2025-05-18	1174	11	0.00	7	0	2025-11-15 10:48:15.695426	1
2025-05-19	988	14	0.00	6	0	2025-11-15 10:48:46.57678	1
2025-05-20	613	8	0.00	7	0	2025-11-15 10:48:46.57678	1
2025-05-21	539	7	0.00	3	0	2025-11-15 10:48:46.57678	1
2025-05-22	600	7	0.00	4	0	2025-11-15 10:48:46.57678	1
2025-05-23	454	7	0.00	6	0	2025-11-15 10:48:46.57678	1
2025-05-24	1192	7	0.00	5	0	2025-11-15 10:48:46.57678	1
2025-05-25	1712	13	0.00	4	0	2025-11-15 10:48:46.57678	1
2025-05-26	524	8	0.00	2	0	2025-11-15 10:49:47.859047	1
2025-05-27	494	7	0.00	1	0	2025-11-15 10:49:47.859047	1
2025-05-28	378	5	0.00	8	0	2025-11-15 10:49:47.859047	1
2025-05-29	488	7	0.00	3	0	2025-11-15 10:49:47.859047	1
2025-05-30	385	6	0.00	3	0	2025-11-15 10:49:47.859047	1
2025-05-31	297	4	0.00	1	0	2025-11-15 10:49:47.859047	1
2025-06-01	352	4	0.00	1	0	2025-11-15 10:49:47.859047	1
2025-06-02	438	7	0.00	3	0	2025-11-15 10:50:38.416927	1
2025-06-03	636	9	0.00	-1	0	2025-11-15 10:50:38.416927	1
2025-06-04	574	9	0.00	2	0	2025-11-15 10:50:38.416927	1
2025-06-05	561	8	0.00	6	0	2025-11-15 10:50:38.416927	1
2025-06-06	325	5	0.00	3	0	2025-11-15 10:50:38.416927	1
2025-06-07	321	5	0.00	0	0	2025-11-15 10:50:38.416927	1
2025-06-08	349	6	0.00	4	0	2025-11-15 10:50:38.416927	1
2025-06-09	398	6	0.00	3	0	2025-11-15 10:51:12.018872	1
2025-06-10	461	8	0.00	1	0	2025-11-15 10:51:12.018872	1
2025-06-11	406	6	0.00	1	0	2025-11-15 10:51:12.018872	1
2025-06-12	441	7	0.00	1	0	2025-11-15 10:51:12.018872	1
2025-06-13	293	5	0.00	3	0	2025-11-15 10:51:12.018872	1
2025-06-14	392	6	0.00	1	0	2025-11-15 10:51:12.018872	1
2025-06-15	454	5	0.00	6	0	2025-11-15 10:51:12.018872	1
2025-06-16	467	7	0.00	2	0	2025-11-15 10:52:22.41805	1
2025-06-17	486	7	0.00	5	0	2025-11-15 10:52:22.41805	1
2025-06-18	707	12	0.00	3	0	2025-11-15 10:52:22.41805	1
2025-06-19	2202	15	0.00	4	0	2025-11-15 10:52:22.41805	1
2025-06-20	2015	13	0.00	4	0	2025-11-15 10:52:22.41805	1
2025-06-21	560	6	0.00	3	0	2025-11-15 10:52:22.41805	1
2025-06-22	561	8	0.00	4	0	2025-11-15 10:52:22.41805	1
2025-06-23	619	9	0.00	7	0	2025-11-15 10:52:58.888985	1
2025-06-24	571	9	0.00	10	0	2025-11-15 10:52:58.888985	1
2025-06-25	772	11	0.00	9	0	2025-11-15 10:52:58.888985	1
2025-06-26	625	10	0.00	4	0	2025-11-15 10:52:58.888985	1
2025-06-27	581	9	0.00	10	0	2025-11-15 10:52:58.888985	1
2025-06-28	508	9	0.00	-1	0	2025-11-15 10:52:58.888985	1
2025-06-29	557	10	0.00	4	0	2025-11-15 10:52:58.888985	1
2025-06-30	568	10	0.00	4	0	2025-11-15 10:54:08.048256	1
2025-07-01	584	9	0.00	5	0	2025-11-15 10:54:08.048256	1
2025-07-02	784	12	0.00	4	0	2025-11-15 10:54:08.048256	1
2025-07-03	1859	16	0.00	10	0	2025-11-15 10:54:08.048256	1
2025-07-04	464	7	0.00	5	0	2025-11-15 10:54:08.048256	1
2025-07-05	558	7	0.00	14	0	2025-11-15 10:54:08.048256	1
2025-07-06	605	11	0.00	11	0	2025-11-15 10:54:08.048256	1
2025-07-07	735	10	0.00	10	0	2025-11-15 10:54:40.16411	1
2025-07-08	1332	12	0.00	5	0	2025-11-15 10:54:40.16411	1
2025-07-09	606	11	0.00	4	0	2025-11-15 10:54:40.16411	1
2025-07-10	507	8	0.00	4	0	2025-11-15 10:54:40.16411	1
2025-07-11	509	9	0.00	4	0	2025-11-15 10:54:40.16411	1
2025-07-12	501	9	0.00	20	0	2025-11-15 10:54:40.16411	1
2025-07-13	490	8	0.00	17	0	2025-11-15 10:54:40.16411	1
2025-07-14	514	8	0.00	6	0	2025-11-15 10:55:23.145308	1
2025-07-15	431	7	0.00	4	0	2025-11-15 10:55:23.145308	1
2025-07-16	488	8	0.00	6	0	2025-11-15 10:55:23.145308	1
2025-07-17	485	10	0.00	10	0	2025-11-15 10:55:23.145308	1
2025-07-18	6917	35	0.00	12	0	2025-11-15 10:55:23.145308	1
2025-07-19	5584	43	0.00	21	0	2025-11-15 10:55:23.145308	1
2025-07-20	4391	29	0.00	18	0	2025-11-15 10:55:23.145308	1
2025-07-21	4755	30	0.00	17	0	2025-11-15 10:55:49.549788	1
2025-07-22	1357	13	0.00	5	0	2025-11-15 10:55:49.549788	1
2025-07-23	1004	12	0.00	7	0	2025-11-15 10:55:49.549788	1
2025-07-24	640	10	0.00	5	0	2025-11-15 10:55:49.549788	1
2025-07-25	562	9	0.00	4	0	2025-11-15 10:55:49.549788	1
2025-07-26	519	9	0.00	5	0	2025-11-15 10:55:49.549788	1
2025-07-27	630	10	0.00	4	0	2025-11-15 10:55:49.549788	1
2025-07-28	704	10	0.00	4	0	2025-11-15 10:56:26.156432	1
2025-07-29	709	12	0.00	10	0	2025-11-15 10:56:26.156432	1
2025-07-30	823	13	0.00	9	0	2025-11-15 10:56:26.156432	1
2025-07-31	2653	23	0.00	9	0	2025-11-15 10:56:26.156432	1
2025-08-01	1558	18	0.00	10	0	2025-11-15 10:56:26.156432	1
2025-08-02	698	10	0.00	4	0	2025-11-15 10:56:26.156432	1
2025-08-03	656	10	0.00	8	0	2025-11-15 10:56:26.156432	1
2025-08-04	726	11	0.00	8	0	2025-11-15 10:57:04.742988	1
2025-08-05	730	14	0.00	5	0	2025-11-15 10:57:04.742988	1
2025-08-06	744	13	0.00	2	0	2025-11-15 10:57:04.742988	1
2025-08-07	936	13	0.00	21	0	2025-11-15 10:57:04.742988	1
2025-08-08	809	13	0.00	17	0	2025-11-15 10:57:04.742988	1
2025-08-09	730	13	0.00	12	0	2025-11-15 10:57:04.742988	1
2025-08-10	696	11	0.00	13	0	2025-11-15 10:57:04.742988	1
2025-08-11	669	12	0.00	10	0	2025-11-15 10:57:31.02875	1
2025-08-12	788	14	0.00	9	0	2025-11-15 10:57:31.02875	1
2025-08-13	682	13	0.00	11	0	2025-11-15 10:57:31.02875	1
2025-08-14	855	13	0.00	3	0	2025-11-15 10:57:31.02875	1
2025-08-15	498	8	0.00	8	0	2025-11-15 10:57:31.02875	1
2025-08-16	515	9	0.00	6	0	2025-11-15 10:57:31.02875	1
2025-08-17	609	12	0.00	14	0	2025-11-15 10:57:31.02875	1
2025-08-18	661	11	0.00	11	0	2025-11-15 10:57:53.818835	1
2025-08-19	769	12	0.00	3	0	2025-11-15 10:57:53.818835	1
2025-08-20	684	10	0.00	15	0	2025-11-15 10:57:53.818835	1
2025-08-21	876	14	0.00	11	0	2025-11-15 10:57:53.818835	1
2025-08-22	1415	24	0.00	4	0	2025-11-15 10:57:53.818835	1
2025-08-23	685	10	0.00	11	0	2025-11-15 10:57:53.818835	1
2025-08-24	775	11	0.00	4	0	2025-11-15 10:57:53.818835	1
2025-08-25	1130	13	0.00	2	0	2025-11-15 10:58:27.727712	1
2025-08-26	1990	18	0.00	6	0	2025-11-15 10:58:27.727712	1
2025-08-27	1902	18	0.00	10	0	2025-11-15 10:58:27.727712	1
2025-08-28	1544	15	0.00	8	0	2025-11-15 10:58:27.727712	1
2025-08-29	705	11	0.00	2	0	2025-11-15 10:58:27.727712	1
2025-08-30	675	10	0.00	17	0	2025-11-15 10:58:27.727712	1
2025-08-31	866	16	0.00	18	0	2025-11-15 10:58:27.727712	1
2025-09-01	818	12	0.00	7	0	2025-11-15 10:59:04.546317	1
2025-09-02	1771	18	0.00	14	0	2025-11-15 10:59:04.546317	1
2025-09-03	1384	19	0.00	14	0	2025-11-15 10:59:04.546317	1
2025-09-04	868	11	0.00	6	0	2025-11-15 10:59:04.546317	1
2025-09-05	1610	14	0.00	8	0	2025-11-15 10:59:04.546317	1
2025-09-06	1866	20	0.00	22	0	2025-11-15 10:59:04.546317	1
2025-09-07	1132	17	0.00	7	0	2025-11-15 10:59:04.546317	1
2025-09-08	797	13	0.00	7	0	2025-11-15 10:59:33.833086	1
2025-09-09	869	13	0.00	11	0	2025-11-15 10:59:33.833086	1
2025-09-10	696	10	0.00	1	0	2025-11-15 10:59:33.833086	1
2025-09-11	692	11	0.00	10	0	2025-11-15 10:59:33.833086	1
2025-09-12	627	10	0.00	10	0	2025-11-15 10:59:33.833086	1
2025-09-13	652	11	0.00	3	0	2025-11-15 10:59:33.833086	1
2025-09-14	537	9	0.00	11	0	2025-11-15 10:59:33.833086	1
2025-09-15	519	9	0.00	7	0	2025-11-15 10:59:56.884196	1
2025-09-16	642	9	0.00	3	0	2025-11-15 10:59:56.884196	1
2025-09-17	1159	44	0.00	9	0	2025-11-15 10:59:56.884196	1
2025-09-18	896	43	0.00	13	0	2025-11-15 10:59:56.884196	1
2025-09-19	771	21	0.00	6	0	2025-11-15 10:59:56.884196	1
2025-09-20	532	13	0.00	11	0	2025-11-15 10:59:56.884196	1
2025-09-21	586	25	0.00	6	0	2025-11-15 10:59:56.884196	1
2025-09-22	775	42	0.00	4	0	2025-11-15 11:00:18.429176	1
2025-09-23	1992	89	0.00	24	0	2025-11-15 11:00:18.429176	1
2025-09-24	1061	69	0.00	13	0	2025-11-15 11:00:18.429176	1
2025-09-25	1092	46	0.00	16	0	2025-11-15 11:00:18.429176	1
2025-09-26	704	25	0.00	9	0	2025-11-15 11:00:18.429176	1
2025-09-27	564	19	0.00	9	0	2025-11-15 11:00:18.429176	1
2025-09-28	652	25	0.00	5	0	2025-11-15 11:00:18.429176	1
2025-09-29	538	28	0.00	3	0	2025-11-15 11:01:11.738152	1
2025-09-30	715	35	0.00	2	0	2025-11-15 11:01:11.738152	1
2025-10-01	589	31	0.00	2	0	2025-11-15 11:01:11.738152	1
2025-10-02	791	41	0.00	2	0	2025-11-15 11:01:11.738152	1
2025-10-03	791	61	0.00	6	0	2025-11-15 11:01:11.738152	1
2025-10-04	543	28	0.00	6	0	2025-11-15 11:01:11.738152	1
2025-10-05	596	25	0.00	6	0	2025-11-15 11:01:11.738152	1
2025-10-06	548	44	0.00	3	0	2025-11-15 11:01:42.433846	1
2025-10-07	578	47	0.00	3	0	2025-11-15 11:01:42.433846	1
2025-10-08	575	35	0.00	6	0	2025-11-15 11:01:42.433846	1
2025-10-09	636	44	0.00	7	0	2025-11-15 11:01:42.433846	1
2025-10-10	507	35	0.00	5	0	2025-11-15 11:01:42.433846	1
2025-10-11	416	35	0.00	5	0	2025-11-15 11:01:42.433846	1
2025-10-12	553	42	0.00	4	0	2025-11-15 11:01:42.433846	1
2025-10-13	508	41	0.00	6	0	2025-11-15 11:02:07.841788	1
2025-10-14	641	37	0.00	6	0	2025-11-15 11:02:07.841788	1
2025-10-15	2759	362	0.00	75	0	2025-11-15 11:02:07.841788	1
2025-10-16	1994	340	0.00	56	0	2025-11-15 11:02:07.841788	1
2025-10-17	845	232	0.00	14	0	2025-11-15 11:02:07.841788	1
2025-10-18	749	173	0.00	14	0	2025-11-15 11:02:07.841788	1
2025-10-19	801	165	0.00	13	0	2025-11-15 11:02:07.841788	1
2025-10-20	515	139	0.00	11	0	2025-11-15 11:02:31.023984	1
2025-10-21	449	118	0.00	1	0	2025-11-15 11:02:31.023984	1
2025-10-22	660	115	0.00	3	0	2025-11-15 11:02:31.023984	1
2025-10-23	397	91	0.00	6	0	2025-11-15 11:02:31.023984	1
2025-10-24	357	74	0.00	2	0	2025-11-15 11:02:31.023984	1
2025-10-25	423	81	0.00	4	0	2025-11-15 11:02:31.023984	1
2025-10-26	580	136	0.00	6	0	2025-11-15 11:02:31.023984	1
2025-10-27	742	163	0.00	13	0	2025-11-15 11:02:58.382425	1
2025-10-28	563	135	0.00	7	0	2025-11-15 11:02:58.382425	1
2025-10-29	472	134	0.00	11	0	2025-11-15 11:02:58.382425	1
2025-10-30	458	100	0.00	9	0	2025-11-15 11:02:58.382425	1
2025-10-31	393	49	0.00	4	0	2025-11-15 11:02:58.382425	1
2025-11-01	354	63	0.00	4	0	2025-11-15 11:02:58.382425	1
2025-11-02	383	50	0.00	4	0	2025-11-15 11:02:58.382425	1
2025-11-03	530	107	0.00	7	0	2025-11-15 11:03:26.614675	1
2025-11-04	551	94	0.00	8	0	2025-11-15 11:03:26.614675	1
2025-11-05	471	88	0.00	14	0	2025-11-15 11:03:26.614675	1
2025-11-06	395	74	0.00	8	0	2025-11-15 11:03:26.614675	1
2025-11-07	336	69	0.00	3	0	2025-11-15 11:03:26.614675	1
2025-11-08	350	74	0.00	5	0	2025-11-15 11:03:26.614675	1
2025-11-09	396	60	0.00	10	0	2025-11-15 11:03:26.614675	1
2025-01-12	700	8	0.00	5	0	2025-11-15 11:04:07.51831	1
\.


--
-- Data for Name: fact_video_weekly_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_video_weekly_metrics (video_id, video_title, week, year, views, watch_time, revenue, subscribers, impressions, created_at, id_subcuenta) FROM stdin;
GsaHpFnC5nk	Caldo de hueso antiresaca y detox para revitalizar tu cuerpo | Vanessa Navarro	1	2025	735	10	0.00	4	0	2025-11-14 15:27:04.682545	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	1	2025	157	6	0.00	7	0	2025-11-14 15:27:04.682545	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	1	2025	57	1	0.00	0	0	2025-11-14 15:27:04.682545	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	1	2025	44	0	0.00	0	0	2025-11-14 15:27:04.682545	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	1	2025	42	1	0.00	0	0	2025-11-14 15:27:04.682545	1
ZkNwyefHeT4	POLVO DE C├üSCARA DE NARANJA | Vanessa Navarro	34	2025	98	4	0.00	2	0	2025-11-15 10:57:54.294287	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	1	2025	25	1	0.00	0	0	2025-11-14 15:27:04.682545	1
XaZRWi7UitI	5X5 desintoxicaci├│n extrema | Vanessa Navarro	1	2025	22	1	0.00	0	0	2025-11-14 15:27:04.682545	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	1	2025	20	0	0.00	0	0	2025-11-14 15:27:04.682545	1
MkoSsb5ZVLw	Infusi├│n para desinflamar | las articulaciones de forma natural y sana| Vanessa Navarro	1	2025	19	0	0.00	0	0	2025-11-14 15:27:04.682545	1
ex_FwGV9Ax8	Desintoxica tu cuerpo y tus intestinos con el protocolo 5x5 ­ƒÑò | Vanessa Navarro	1	2025	19	0	0.00	0	0	2025-11-14 15:27:04.682545	1
3ypmp4-vt3o	Detox del apio: limpia tu organismo y reduce el estr├®s naturalmente | Vanessa Navarro	2	2025	84	1	0.00	0	0	2025-11-14 15:35:08.726954	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	2	2025	46	1	0.00	1	0	2025-11-14 15:35:08.726954	1
GsaHpFnC5nk	Caldo de hueso antiresaca y detox para revitalizar tu cuerpo | Vanessa Navarro	2	2025	24	0	0.00	0	0	2025-11-14 15:35:08.726954	1
ZkNwyefHeT4	POLVO DE C├üSCARA DE NARANJA | Vanessa Navarro	2	2025	22	1	0.00	0	0	2025-11-14 15:35:08.726954	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	2	2025	21	0	0.00	0	0	2025-11-14 15:35:08.726954	1
-GWnfLTSBeo	Los antioxidantes ayudan a prevenir el envejecimiento prematuro | Vanessa Navarro	3	2025	3126	43	0.00	20	0	2025-11-15 09:31:02.742926	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	3	2025	303	6	0.00	1	0	2025-11-15 09:31:02.742926	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	3	2025	140	5	0.00	2	0	2025-11-15 09:31:02.742926	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	3	2025	66	2	0.00	2	0	2025-11-15 09:31:02.742926	1
UJu16U5DCFk	Es hora de desintoxicar tu organismo con este jugo verde ­ƒî┐­ƒÆÜ | Vanessa Navarro	3	2025	40	0	0.00	0	0	2025-11-15 09:31:02.742926	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	3	2025	40	1	0.00	0	0	2025-11-15 09:31:02.742926	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	3	2025	32	1	0.00	0	0	2025-11-15 09:31:02.742926	1
qdVlZjSNbR0	Un gran prop├│sito para este a├▒o: dile adi├│s a esta bebida ­ƒÜ½­ƒÑñ | Vanessa Navarro	3	2025	26	0	0.00	0	0	2025-11-15 09:31:02.742926	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	3	2025	24	0	0.00	1	0	2025-11-15 09:31:02.742926	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	3	2025	23	1	0.00	0	0	2025-11-15 09:31:02.742926	1
-GWnfLTSBeo	Los antioxidantes ayudan a prevenir el envejecimiento prematuro | Vanessa Navarro	4	2025	519	7	0.00	5	0	2025-11-15 09:31:54.233938	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	4	2025	143	3	0.00	1	0	2025-11-15 09:31:54.233938	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	4	2025	99	4	0.00	3	0	2025-11-15 09:31:54.233938	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	4	2025	81	2	0.00	2	0	2025-11-15 09:31:54.233938	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	4	2025	43	1	0.00	3	0	2025-11-15 09:31:54.233938	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	4	2025	32	1	0.00	0	0	2025-11-15 09:31:54.233938	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	4	2025	28	1	0.00	0	0	2025-11-15 09:31:54.233938	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	4	2025	25	0	0.00	0	0	2025-11-15 09:31:54.233938	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	4	2025	20	1	0.00	0	0	2025-11-15 09:31:54.233938	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	4	2025	20	1	0.00	0	0	2025-11-15 09:31:54.233938	1
a6GqwpRHUqE	Este ingrediente com├║n acelera el envejecimiento de tu piel ­ƒÿ▒ | Vanessa Navarro	5	2025	544	6	0.00	2	0	2025-11-15 09:33:17.509535	1
IyzGC0fa7ME	El poder del caf├® Ôÿò | Beneficios para tu longevidad, metabolismo y salud | Vanessa Navarro	5	2025	516	9	0.00	3	0	2025-11-15 09:33:17.509535	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	5	2025	330	7	0.00	4	0	2025-11-15 09:33:17.509535	1
7rR2eBfmjFA	Jugo rico en BIOTINA - La vitamina de la belleza| Vanessa Navarro	5	2025	141	3	0.00	2	0	2025-11-15 09:33:17.509535	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	5	2025	135	5	0.00	3	0	2025-11-15 09:33:17.509535	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	5	2025	71	2	0.00	1	0	2025-11-15 09:33:17.509535	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	5	2025	37	0	0.00	0	0	2025-11-15 09:33:17.509535	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	5	2025	35	2	0.00	0	0	2025-11-15 09:33:17.509535	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	5	2025	21	1	0.00	1	0	2025-11-15 09:33:17.509535	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	5	2025	18	0	0.00	0	0	2025-11-15 09:33:17.509535	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	6	2025	837	17	0.00	5	0	2025-11-15 09:50:40.220668	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	6	2025	149	7	0.00	5	0	2025-11-15 09:50:40.220668	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	6	2025	89	2	0.00	4	0	2025-11-15 09:50:40.220668	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	6	2025	65	1	0.00	2	0	2025-11-15 09:50:40.220668	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	6	2025	51	1	0.00	0	0	2025-11-15 09:50:40.220668	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	6	2025	29	1	0.00	0	0	2025-11-15 09:50:40.220668	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	6	2025	27	0	0.00	0	0	2025-11-15 09:50:40.220668	1
f8f53egnLgI	RECETA VIRAL: Mermelada de ar├índanos sin az├║car | Vanessa Navarr	6	2025	21	0	0.00	0	0	2025-11-15 09:50:40.220668	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	6	2025	20	0	0.00	0	0	2025-11-15 09:50:40.220668	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	6	2025	19	0	0.00	3	0	2025-11-15 09:50:40.220668	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	7	2025	904	18	0.00	7	0	2025-11-15 09:51:19.979662	1
4UJk7vw48O4	Endulza tu vida de manera saludable | Efectos anti-envejecimiento #vanenavarrotv | Vanessa Navarro	7	2025	599	11	0.00	4	0	2025-11-15 09:51:19.979662	1
lX82q7JNGDw	Pan de Banano y ar├índanos, un postre SIN REMORDIMIENTO | Vanessa Navarro	7	2025	487	6	0.00	2	0	2025-11-15 09:51:19.979662	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	7	2025	150	6	0.00	2	0	2025-11-15 09:51:19.979662	1
nlz-8gs95Us	Jugo verde con col├ígeno| Vanessa Navarro	7	2025	133	2	0.00	0	0	2025-11-15 09:51:19.979662	1
-eqLFiFD9Gw	Este secreto de juventud y salud te va a sorprender ­ƒÑæÔ£¿ | Vanessa Navarro	7	2025	79	1	0.00	0	0	2025-11-15 09:51:19.979662	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	7	2025	77	1	0.00	0	0	2025-11-15 09:51:19.979662	1
-42fwKClvHY	Vinagre de manzana casero ­ƒìÄ | Receta f├ícil y natural con todos sus beneficios | Vanessa Navarro	7	2025	76	1	0.00	0	0	2025-11-15 09:51:19.979662	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	7	2025	71	2	0.00	2	0	2025-11-15 09:51:19.979662	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	7	2025	63	2	0.00	0	0	2025-11-15 09:51:19.979662	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	8	2025	1312	28	0.00	6	0	2025-11-15 09:52:00.301251	1
WMYRAnB9zZE	Este h├íbito simple activa tu metabolismo y transforma tu salud ­ƒÆº­ƒìï | Vanessa Navarro	8	2025	952	7	0.00	6	0	2025-11-15 09:52:00.301251	1
LH6q3Oe9meI	Chocolate caliente saludable, antioxidante y delicioso ­ƒì½ | Vanessa Navarro	8	2025	467	6	0.00	-1	0	2025-11-15 09:52:00.301251	1
T3liIBWfRmk	Chucrut, un fermento maravilloso para tu flora intestinal | Vanessa Navarro	8	2025	442	6	0.00	2	0	2025-11-15 09:52:00.301251	1
OV7zc_f2Hs0	Agua tibia con lim├│n: desintoxica tu cuerpo y activa tu metabolismo ­ƒìï | Vanessa Navarro	8	2025	421	9	0.00	5	0	2025-11-15 09:52:00.301251	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	8	2025	158	6	0.00	5	0	2025-11-15 09:52:00.301251	1
7-fCT_bdrBU	Jugo para aumentar la producci├│n de ├ícido hialur├│nico en tu piel #vanenavarrotv #tips ´┐╝	8	2025	124	1	0.00	2	0	2025-11-15 09:52:00.301251	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	8	2025	98	1	0.00	1	0	2025-11-15 09:52:00.301251	1
y8nENVCwAnU	Ayuno intermitente: el h├íbito que desintoxica tu cuerpo y previene enfermedades ­ƒî┐ | Vanessa Navarro	8	2025	96	1	0.00	-1	0	2025-11-15 09:52:00.301251	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	8	2025	54	1	0.00	4	0	2025-11-15 09:52:00.301251	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	9	2025	1157	25	0.00	7	0	2025-11-15 09:53:18.553788	1
7-fCT_bdrBU	Jugo para aumentar la producci├│n de ├ícido hialur├│nico en tu piel #vanenavarrotv #tips ´┐╝	9	2025	698	14	0.00	1	0	2025-11-15 09:53:18.553788	1
dWRJjVOMUR8	┬┐El az├║car morena es la mejor alternativa para endulzar? | Vanessa Navarro	9	2025	451	6	0.00	0	0	2025-11-15 09:53:18.553788	1
OV7zc_f2Hs0	Agua tibia con lim├│n: desintoxica tu cuerpo y activa tu metabolismo ­ƒìï | Vanessa Navarro	9	2025	423	11	0.00	5	0	2025-11-15 09:53:18.553788	1
WMYRAnB9zZE	Este h├íbito simple activa tu metabolismo y transforma tu salud ­ƒÆº­ƒìï | Vanessa Navarro	9	2025	346	3	0.00	5	0	2025-11-15 09:53:18.553788	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	9	2025	164	7	0.00	1	0	2025-11-15 09:53:18.553788	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	9	2025	90	1	0.00	0	0	2025-11-15 09:53:18.553788	1
T3liIBWfRmk	Chucrut, un fermento maravilloso para tu flora intestinal | Vanessa Navarro	9	2025	73	1	0.00	0	0	2025-11-15 09:53:18.553788	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	9	2025	65	2	0.00	0	0	2025-11-15 09:53:18.553788	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	9	2025	55	1	0.00	0	0	2025-11-15 09:53:18.553788	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	10	2025	1206	25	0.00	5	0	2025-11-15 10:27:37.643174	1
ex_FwGV9Ax8	Desintoxica tu cuerpo y tus intestinos con el protocolo 5x5 ­ƒÑò | Vanessa Navarro	10	2025	399	7	0.00	1	0	2025-11-15 10:27:37.643174	1
o8epvXlTQjw	Transforma tu salud y energ├¡a con este jugo detox verde ­ƒî┐ | Vanessa Navarro	10	2025	278	4	0.00	1	0	2025-11-15 10:27:37.643174	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	10	2025	200	8	0.00	1	0	2025-11-15 10:27:37.643174	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	10	2025	67	1	0.00	1	0	2025-11-15 10:27:37.643174	1
KKeC2aD7p4Y	Te vas a SORPRENDER: tanto poder en un solo alimento | Vanessa Navarro	10	2025	62	1	0.00	0	0	2025-11-15 10:27:37.643174	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	10	2025	49	1	0.00	0	0	2025-11-15 10:27:37.643174	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	10	2025	34	1	0.00	0	0	2025-11-15 10:27:37.643174	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	10	2025	28	0	0.00	0	0	2025-11-15 10:27:37.643174	1
tQ7j1or8AZU	Jugo detox de remolacha y lim├│n ­ƒìï­ƒÆ£ | Limpia y regenera tu h├¡gado naturalmente ­ƒî┐ | Vanessa Navarro	10	2025	25	0	0.00	0	0	2025-11-15 10:27:37.643174	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	11	2025	1275	28	0.00	8	0	2025-11-15 10:28:11.076466	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	11	2025	436	15	0.00	8	0	2025-11-15 10:28:11.076466	1
EgG8GsnrSJ4	┬┐Prueba viral solo para hombres? Descubre la verdad detr├ís de este reto | Vanessa Navarro	11	2025	433	4	0.00	0	0	2025-11-15 10:28:11.076466	1
ZL3AinjUCNk	Alivia la gripa de forma r├ípida con este antibi├│tico natural | Vanessa Navarro	11	2025	123	2	0.00	-1	0	2025-11-15 10:28:11.076466	1
0FXkZV_PxxU	As├¡ ayudas a tu h├¡gado a funcionar mejor en solo 8 d├¡as | Vanessa Navarro	11	2025	115	2	0.00	1	0	2025-11-15 10:28:11.076466	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	11	2025	67	1	0.00	1	0	2025-11-15 10:28:11.076466	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	11	2025	57	1	0.00	0	0	2025-11-15 10:28:11.076466	1
KKeC2aD7p4Y	Te vas a SORPRENDER: tanto poder en un solo alimento | Vanessa Navarro	11	2025	43	1	0.00	0	0	2025-11-15 10:28:11.076466	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	11	2025	31	1	0.00	0	0	2025-11-15 10:28:11.076466	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	11	2025	27	1	0.00	0	0	2025-11-15 10:28:11.076466	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	12	2025	1260	27	0.00	6	0	2025-11-15 10:28:49.543077	1
DBzK-gf83Po	┬íUn milagro de la naturaleza! Peque├▒os pero PODEROSOS| Vanessa Navarro	12	2025	890	9	0.00	2	0	2025-11-15 10:28:49.543077	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	12	2025	435	16	0.00	5	0	2025-11-15 10:28:49.543077	1
EgG8GsnrSJ4	┬┐Prueba viral solo para hombres? Descubre la verdad detr├ís de este reto | Vanessa Navarro	12	2025	168	2	0.00	0	0	2025-11-15 10:28:49.543077	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	12	2025	140	5	0.00	17	0	2025-11-15 10:28:49.543077	1
LTQ5HejKy54	┬íNo vas a creer todo lo que puede hacer por ti! ­ƒºäÔ£¿ La cura del ajo | Vanessa Navarro	12	2025	138	2	0.00	3	0	2025-11-15 10:28:49.543077	1
fX2_dzPQ2kI	Shot antigripal: un boost natural para tu bienestar ­ƒìï­ƒºäÔ£¿| Vanessa Navarro	12	2025	93	1	0.00	9	0	2025-11-15 10:28:49.543077	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	12	2025	71	1	0.00	1	0	2025-11-15 10:28:49.543077	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	12	2025	69	2	0.00	0	0	2025-11-15 10:28:49.543077	1
Imz5W3S5ulY	LA CURA DEL AJO | Vanessa Navarro #wellness #tips #viandassaludables #salud #vanenavarrotv	12	2025	41	0	0.00	2	0	2025-11-15 10:28:49.543077	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	13	2025	1393	30	0.00	7	0	2025-11-15 10:29:23.149715	1
bjG198tYMBU	Aprende a hidratarte correctamente para activar tu cerebro y tu metabolismo| Vanessa Navarro	13	2025	705	8	0.00	3	0	2025-11-15 10:29:23.149715	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	13	2025	684	24	0.00	7	0	2025-11-15 10:29:23.149715	1
DBzK-gf83Po	┬íUn milagro de la naturaleza! Peque├▒os pero PODEROSOS| Vanessa Navarro	13	2025	333	5	0.00	1	0	2025-11-15 10:29:23.149715	1
dkal4w0i9og	El secreto de la longevidad seg├║n Harvard: la clave para vivir m├ís y mejor | Vanessa Navarro	13	2025	228	2	0.00	0	0	2025-11-15 10:29:23.149715	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	13	2025	171	4	0.00	2	0	2025-11-15 10:29:23.149715	1
LTQ5HejKy54	┬íNo vas a creer todo lo que puede hacer por ti! ­ƒºäÔ£¿ La cura del ajo | Vanessa Navarro	13	2025	135	2	0.00	1	0	2025-11-15 10:29:23.149715	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	13	2025	107	2	0.00	0	0	2025-11-15 10:29:23.149715	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	13	2025	99	3	0.00	5	0	2025-11-15 10:29:23.149715	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	13	2025	66	1	0.00	0	0	2025-11-15 10:29:23.149715	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	14	2025	2415	30	0.00	6	0	2025-11-15 10:30:58.396341	1
dkal4w0i9og	El secreto de la longevidad seg├║n Harvard: la clave para vivir m├ís y mejor | Vanessa Navarro	14	2025	829	7	0.00	3	0	2025-11-15 10:30:58.396341	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	14	2025	742	26	0.00	10	0	2025-11-15 10:30:58.396341	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	14	2025	373	3	0.00	2	0	2025-11-15 10:30:58.396341	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	14	2025	233	2	0.00	1	0	2025-11-15 10:30:58.396341	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	14	2025	122	3	0.00	0	0	2025-11-15 10:30:58.396341	1
zRgGUzOQNuk	Agua Antioxidante, Antienvejecimiento| Vanessa Navarro	14	2025	121	2	0.00	0	0	2025-11-15 10:30:58.396341	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	14	2025	116	1	0.00	2	0	2025-11-15 10:30:58.396341	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	14	2025	79	1	0.00	1	0	2025-11-15 10:30:58.396341	1
bjG198tYMBU	Aprende a hidratarte correctamente para activar tu cerebro y tu metabolismo| Vanessa Navarro	14	2025	51	0	0.00	0	0	2025-11-15 10:30:58.396341	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	15	2025	2493	32	0.00	6	0	2025-11-15 10:31:54.737039	1
-7k0VBEg23g	Mejora el estado de tu mente con estos consejos ­ƒºáÔ£¿ | Vanessa Navarro	15	2025	920	7	0.00	3	0	2025-11-15 10:31:54.737039	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	15	2025	794	26	0.00	14	0	2025-11-15 10:31:54.737039	1
LTQ5HejKy54	┬íNo vas a creer todo lo que puede hacer por ti! ­ƒºäÔ£¿ La cura del ajo | Vanessa Navarro	15	2025	508	7	0.00	2	0	2025-11-15 10:31:54.737039	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	15	2025	214	2	0.00	0	0	2025-11-15 10:31:54.737039	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	15	2025	205	5	0.00	4	0	2025-11-15 10:31:54.737039	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	15	2025	125	1	0.00	2	0	2025-11-15 10:31:54.737039	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	15	2025	62	0	0.00	0	0	2025-11-15 10:31:54.737039	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	15	2025	43	1	0.00	2	0	2025-11-15 10:31:54.737039	1
5Qu3ihLQ6Ew	Manos de porcelana| tratamiento de belleza para manos y pies | Resultados visibles| Vanessa Navarro	15	2025	42	0	0.00	0	0	2025-11-15 10:31:54.737039	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	16	2025	2281	36	0.00	18	0	2025-11-15 10:32:27.024502	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	16	2025	490	17	0.00	11	0	2025-11-15 10:32:27.024502	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	16	2025	194	2	0.00	0	0	2025-11-15 10:32:27.024502	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	16	2025	160	1	0.00	2	0	2025-11-15 10:32:27.024502	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	16	2025	113	3	0.00	2	0	2025-11-15 10:32:27.024502	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	16	2025	65	1	0.00	0	0	2025-11-15 10:32:27.024502	1
-7k0VBEg23g	Mejora el estado de tu mente con estos consejos ­ƒºáÔ£¿ | Vanessa Navarro	16	2025	46	0	0.00	0	0	2025-11-15 10:32:27.024502	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	16	2025	46	1	0.00	0	0	2025-11-15 10:32:27.024502	1
LTQ5HejKy54	┬íNo vas a creer todo lo que puede hacer por ti! ­ƒºäÔ£¿ La cura del ajo | Vanessa Navarro	16	2025	45	1	0.00	2	0	2025-11-15 10:32:27.024502	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	16	2025	34	1	0.00	9	0	2025-11-15 10:32:27.024502	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	17	2025	4267	54	0.00	22	0	2025-11-15 10:33:02.714488	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	17	2025	407	14	0.00	4	0	2025-11-15 10:33:02.714488	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	17	2025	210	2	0.00	2	0	2025-11-15 10:33:02.714488	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	17	2025	128	1	0.00	1	0	2025-11-15 10:33:02.714488	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	17	2025	125	3	0.00	2	0	2025-11-15 10:33:02.714488	1
o8epvXlTQjw	Transforma tu salud y energ├¡a con este jugo detox verde ­ƒî┐ | Vanessa Navarro	17	2025	121	2	0.00	2	0	2025-11-15 10:33:02.714488	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	17	2025	115	4	0.00	17	0	2025-11-15 10:33:02.714488	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	17	2025	88	1	0.00	0	0	2025-11-15 10:33:02.714488	1
MYqcOmh-z8E	Secreto de longevidad revelado por la Universidad de Harvard| Vanessa Navarro	17	2025	74	1	0.00	1	0	2025-11-15 10:33:02.714488	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	17	2025	54	0	0.00	0	0	2025-11-15 10:33:02.714488	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	18	2025	2960	41	0.00	17	0	2025-11-15 10:34:07.146071	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	18	2025	349	14	0.00	5	0	2025-11-15 10:34:07.146071	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	18	2025	294	4	0.00	0	0	2025-11-15 10:34:07.146071	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	18	2025	126	1	0.00	2	0	2025-11-15 10:34:07.146071	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	18	2025	63	0	0.00	0	0	2025-11-15 10:34:07.146071	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	18	2025	60	1	0.00	0	0	2025-11-15 10:34:07.146071	1
A_MHSG-OXs4	INFUSI├ôN DIUR├ëTICA Y DEPURATIVA| Vanessa Navarro	18	2025	35	0	0.00	0	0	2025-11-15 10:34:07.146071	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	18	2025	33	1	0.00	0	0	2025-11-15 10:34:07.146071	1
C-FhBirqVEw	DESINTOXICA TU H├ìGADO CON LA PEPA DEL AGUACATE | Vanessa Navarro	18	2025	32	0	0.00	0	0	2025-11-15 10:34:07.146071	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	18	2025	29	0	0.00	0	0	2025-11-15 10:34:07.146071	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	19	2025	1724	23	0.00	7	0	2025-11-15 10:47:29.072226	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	19	2025	205	2	0.00	0	0	2025-11-15 10:47:29.072226	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	19	2025	147	5	0.00	2	0	2025-11-15 10:47:29.072226	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	19	2025	95	1	0.00	2	0	2025-11-15 10:47:29.072226	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	19	2025	77	1	0.00	0	0	2025-11-15 10:47:29.072226	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	19	2025	48	1	0.00	1	0	2025-11-15 10:47:29.072226	1
A_MHSG-OXs4	INFUSI├ôN DIUR├ëTICA Y DEPURATIVA| Vanessa Navarro	19	2025	38	0	0.00	0	0	2025-11-15 10:47:29.072226	1
C-FhBirqVEw	DESINTOXICA TU H├ìGADO CON LA PEPA DEL AGUACATE | Vanessa Navarro	19	2025	34	0	0.00	0	0	2025-11-15 10:47:29.072226	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	19	2025	29	0	0.00	0	0	2025-11-15 10:47:29.072226	1
EqkfyIqNKEc	LA CURA DEL AJO | Vanessa Navarro	19	2025	24	1	0.00	2	0	2025-11-15 10:47:29.072226	1
Mq6KtrjQemQ	Con los a├▒os el deterioro cerebral es un hecho. Por eso aqu├¡ te muestro una forma de protegerlo.	20	2025	8907	52	0.00	38	0	2025-11-15 10:48:16.260052	1
RRr_eT1S3Sw	┬íTe vas a sorprender! Este pan de quinoa y ch├¡a es delicioso y s├║per saludable ­ƒì×Ô£¿ | Vanessa Navarro	20	2025	7390	38	0.00	28	0	2025-11-15 10:48:16.260052	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	20	2025	1439	20	0.00	4	0	2025-11-15 10:48:16.260052	1
n_wjCmecI_c	┬íDescubre los beneficios de este delicioso, chocolate, antioxidante y digestivo!| Vanessa Navarro	20	2025	1054	9	0.00	2	0	2025-11-15 10:48:16.260052	1
01dMGf26cYM	Uno de los secretos de Martha Bola├▒os, para mantenerse as├¡ de bella| Vanessa Navarro	20	2025	529	2	0.00	0	0	2025-11-15 10:48:16.260052	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	20	2025	297	3	0.00	3	0	2025-11-15 10:48:16.260052	1
e9OMGPolJ2I	┬íNo vas a creer lo milagroso de este alimento para la hipertensi├│n!| Vanessa Navarro	20	2025	291	3	0.00	0	0	2025-11-15 10:48:16.260052	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	20	2025	173	7	0.00	3	0	2025-11-15 10:48:16.260052	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	20	2025	72	1	0.00	0	0	2025-11-15 10:48:16.260052	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	20	2025	69	1	0.00	1	0	2025-11-15 10:48:16.260052	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	21	2025	1461	22	0.00	5	0	2025-11-15 10:48:47.134176	1
0zTPW7Ch3t4	Un peque├▒o h├íbito que mejora tu salud: el poder de la cebolla roja cruda | Vanessa Navarro	21	2025	1449	5	0.00	1	0	2025-11-15 10:48:47.134176	1
WOCmTn-rRAg	┬┐Sab├¡as que tu intestino es tu segundo cerebro? ­ƒç¿­ƒç┤ ­ƒç║­ƒç© | Vanessa Navarro	21	2025	767	4	0.00	1	0	2025-11-15 10:48:47.134176	1
iqDGPoGx4ck	Esta delicia es completamente saludable y mejora tu digesti├│n| Vanessa Navarro	21	2025	385	4	0.00	5	0	2025-11-15 10:48:47.134176	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	21	2025	282	3	0.00	1	0	2025-11-15 10:48:47.134176	1
Mq6KtrjQemQ	Con los a├▒os el deterioro cerebral es un hecho. Por eso aqu├¡ te muestro una forma de protegerlo.	21	2025	241	1	0.00	0	0	2025-11-15 10:48:47.134176	1
ckHb1wn-7Qw	Infusi├│n clavos de olor para dormir| Vanessa Navarro	43	2025	51	1	0.00	0	0	2025-11-15 11:02:31.604331	1
01dMGf26cYM	Uno de los secretos de Martha Bola├▒os, para mantenerse as├¡ de bella| Vanessa Navarro	21	2025	226	2	0.00	1	0	2025-11-15 10:48:47.134176	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	21	2025	222	8	0.00	4	0	2025-11-15 10:48:47.134176	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	21	2025	97	1	0.00	0	0	2025-11-15 10:48:47.134176	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	21	2025	88	1	0.00	0	0	2025-11-15 10:48:47.134176	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	22	2025	1160	18	0.00	4	0	2025-11-15 10:49:48.448114	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	22	2025	295	4	0.00	0	0	2025-11-15 10:49:48.448114	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	22	2025	206	7	0.00	7	0	2025-11-15 10:49:48.448114	1
0zTPW7Ch3t4	Un peque├▒o h├íbito que mejora tu salud: el poder de la cebolla roja cruda | Vanessa Navarro	22	2025	103	1	0.00	0	0	2025-11-15 10:49:48.448114	1
WOCmTn-rRAg	┬┐Sab├¡as que tu intestino es tu segundo cerebro? ­ƒç¿­ƒç┤ ­ƒç║­ƒç© | Vanessa Navarro	22	2025	90	1	0.00	0	0	2025-11-15 10:49:48.448114	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	22	2025	86	1	0.00	1	0	2025-11-15 10:49:48.448114	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	22	2025	65	1	0.00	0	0	2025-11-15 10:49:48.448114	1
A_MHSG-OXs4	INFUSI├ôN DIUR├ëTICA Y DEPURATIVA| Vanessa Navarro	22	2025	58	0	0.00	1	0	2025-11-15 10:49:48.448114	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	22	2025	42	1	0.00	0	0	2025-11-15 10:49:48.448114	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	22	2025	41	1	0.00	0	0	2025-11-15 10:49:48.448114	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	23	2025	1224	18	0.00	4	0	2025-11-15 10:50:38.953257	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	23	2025	331	4	0.00	2	0	2025-11-15 10:50:38.953257	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	23	2025	173	7	0.00	1	0	2025-11-15 10:50:38.953257	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	23	2025	121	2	0.00	0	0	2025-11-15 10:50:38.953257	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	23	2025	97	1	0.00	1	0	2025-11-15 10:50:38.953257	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	23	2025	93	3	0.00	2	0	2025-11-15 10:50:38.953257	1
A_MHSG-OXs4	INFUSI├ôN DIUR├ëTICA Y DEPURATIVA| Vanessa Navarro	23	2025	85	1	0.00	0	0	2025-11-15 10:50:38.953257	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	23	2025	80	2	0.00	1	0	2025-11-15 10:50:38.953257	1
0zTPW7Ch3t4	Un peque├▒o h├íbito que mejora tu salud: el poder de la cebolla roja cruda | Vanessa Navarro	23	2025	71	1	0.00	0	0	2025-11-15 10:50:38.953257	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	23	2025	71	1	0.00	1	0	2025-11-15 10:50:38.953257	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	24	2025	1201	18	0.00	3	0	2025-11-15 10:51:12.611443	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	24	2025	315	12	0.00	6	0	2025-11-15 10:51:12.611443	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	24	2025	306	3	0.00	1	0	2025-11-15 10:51:12.611443	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	24	2025	94	1	0.00	0	0	2025-11-15 10:51:12.611443	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	24	2025	86	1	0.00	0	0	2025-11-15 10:51:12.611443	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	24	2025	44	0	0.00	0	0	2025-11-15 10:51:12.611443	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	24	2025	42	0	0.00	0	0	2025-11-15 10:51:12.611443	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	24	2025	41	1	0.00	0	0	2025-11-15 10:51:12.611443	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	24	2025	40	0	0.00	0	0	2025-11-15 10:51:12.611443	1
z82n21BaezM	MASCARILLA MILAGROS DE LINAZA Y CANELA | Vanessa Navarro	24	2025	35	1	0.00	0	0	2025-11-15 10:51:12.611443	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	25	2025	1889	29	0.00	11	0	2025-11-15 10:52:23.058077	1
lEkh7j_ROW0	Lo que ni te imaginabas sobre el huevo| Vanessa Navarro	25	2025	1675	6	0.00	0	0	2025-11-15 10:52:23.058077	1
Z8tmI8xPE-s	Cuando est├ís en tus horas de ayuno, toma esto para potenciar tus resultados | Vanessa Navarro	25	2025	1246	3	0.00	0	0	2025-11-15 10:52:23.058077	1
FHj9N6bVGPo	Pan de banano y ar├índanos ­ƒìî­ƒÆ£ demasiado delicioso para ser tan saludable | Vanessa Navarro	25	2025	515	2	0.00	0	0	2025-11-15 10:52:23.058077	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	25	2025	308	12	0.00	3	0	2025-11-15 10:52:23.058077	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	25	2025	300	3	0.00	1	0	2025-11-15 10:52:23.058077	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	25	2025	104	1	0.00	2	0	2025-11-15 10:52:23.058077	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	25	2025	75	1	0.00	0	0	2025-11-15 10:52:23.058077	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	25	2025	67	1	0.00	1	0	2025-11-15 10:52:23.058077	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	25	2025	58	1	0.00	0	0	2025-11-15 10:52:23.058077	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	26	2025	1990	28	0.00	10	0	2025-11-15 10:52:59.365609	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	26	2025	468	16	0.00	10	0	2025-11-15 10:52:59.365609	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	26	2025	385	4	0.00	1	0	2025-11-15 10:52:59.365609	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	26	2025	128	1	0.00	0	0	2025-11-15 10:52:59.365609	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	26	2025	71	1	0.00	2	0	2025-11-15 10:52:59.365609	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	26	2025	64	0	0.00	0	0	2025-11-15 10:52:59.365609	1
ZkNwyefHeT4	POLVO DE C├üSCARA DE NARANJA | Vanessa Navarro	26	2025	51	2	0.00	2	0	2025-11-15 10:52:59.365609	1
lEkh7j_ROW0	Lo que ni te imaginabas sobre el huevo| Vanessa Navarro	26	2025	50	0	0.00	0	0	2025-11-15 10:52:59.365609	1
aRrEv4FqenE	Leche de ch├¡a para la tiroides ­ƒÑøÔ£¿ Salud y bienestar natural | Vanessa Navarro	26	2025	49	1	0.00	1	0	2025-11-15 10:52:59.365609	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	26	2025	43	0	0.00	1	0	2025-11-15 10:52:59.365609	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	27	2025	1469	24	0.00	11	0	2025-11-15 10:54:08.707955	1
PW68iOnR0tU	Mejora tu digesti├│n con este jugo funcional natural y depurativo | Vanessa Navarro	27	2025	1338	7	0.00	6	0	2025-11-15 10:54:08.707955	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	27	2025	474	17	0.00	7	0	2025-11-15 10:54:08.707955	1
LTQ5HejKy54	┬íNo vas a creer todo lo que puede hacer por ti! ­ƒºäÔ£¿ La cura del ajo | Vanessa Navarro	27	2025	456	6	0.00	3	0	2025-11-15 10:54:08.707955	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	27	2025	315	3	0.00	2	0	2025-11-15 10:54:08.707955	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	27	2025	119	1	0.00	0	0	2025-11-15 10:54:08.707955	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	27	2025	87	1	0.00	1	0	2025-11-15 10:54:08.707955	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	27	2025	73	1	0.00	0	0	2025-11-15 10:54:08.707955	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	27	2025	69	1	0.00	0	0	2025-11-15 10:54:08.707955	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	27	2025	49	0	0.00	0	0	2025-11-15 10:54:08.707955	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	28	2025	1161	18	0.00	2	0	2025-11-15 10:54:40.698106	1
KI7iCstdNwk	Internada en una cl├¡nica del sue├▒o: c├│mo logr├® dormir 8 horas sin pastillas | Vanessa Navarro	28	2025	1094	6	0.00	3	0	2025-11-15 10:54:40.698106	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	28	2025	404	4	0.00	1	0	2025-11-15 10:54:40.698106	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	28	2025	399	14	0.00	3	0	2025-11-15 10:54:40.698106	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	28	2025	118	1	0.00	2	0	2025-11-15 10:54:40.698106	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	28	2025	100	1	0.00	0	0	2025-11-15 10:54:40.698106	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	28	2025	92	2	0.00	0	0	2025-11-15 10:54:40.698106	1
PW68iOnR0tU	Mejora tu digesti├│n con este jugo funcional natural y depurativo | Vanessa Navarro	28	2025	76	1	0.00	0	0	2025-11-15 10:54:40.698106	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	28	2025	65	1	0.00	0	0	2025-11-15 10:54:40.698106	1
ZkNwyefHeT4	POLVO DE C├üSCARA DE NARANJA | Vanessa Navarro	28	2025	55	2	0.00	0	0	2025-11-15 10:54:40.698106	1
0SouAXUFtAc	┬┐Tienes problemas de digesti├│n? ┬íAqu├¡ te muestro una GRAN soluci├│n!| Vanessa Navarro	29	2025	3276	17	0.00	1	0	2025-11-15 10:55:23.733038	1
oAVveXh_8Qw	Hackea tu biolog├¡a: el poder del biohacking para transformar tu cuerpo y tu mente | Vanessa Navarro	29	2025	1669	5	0.00	2	0	2025-11-15 10:55:23.733038	1
pzLdKj29hwE	Esta infusi├│n te va a sorprender con sus beneficios ´┐╝| Vanessa Navarro	29	2025	1479	8	0.00	3	0	2025-11-15 10:55:23.733038	1
Twmv74thbUg	Aqu├¡ te dar├ís cuenta que tu salud mental empieza desde lo que comes ´┐╝| Vanessa Navarro	29	2025	1449	4	0.00	0	0	2025-11-15 10:55:23.733038	1
M7Ijg_TGlZA	┬┐Qu├® magnesio deber├¡as consumir seg├║n tus s├¡ntomas? | Vanessa Navarro	29	2025	1240	15	0.00	9	0	2025-11-15 10:55:23.733038	1
uGRrZ7eMlXk	Aprende a dominar tu cuerpo y mente en la menopausia| Vanessa Navarro	29	2025	1169	9	0.00	6	0	2025-11-15 10:55:23.733038	1
duYM658lO8s	ESTO NO LO CONOC├ìAS: Descubre los sorprendentes beneficios de la miel de abejas | Vanessa Navarro	29	2025	1146	8	0.00	4	0	2025-11-15 10:55:23.733038	1
3BkN0Kluo6o	Un enemigo silencioso en tu cocina: la verdad sobre las esponjas | Vanessa Navarro	29	2025	1130	4	0.00	3	0	2025-11-15 10:55:23.733038	1
4lM9gKUs9ZA	┬íHay alimentos que contribuyen a tu felicidad! Desc├║brelo| Vanessa Navarro	29	2025	1127	6	0.00	1	0	2025-11-15 10:55:23.733038	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	29	2025	1004	14	0.00	1	0	2025-11-15 10:55:23.733038	1
0SouAXUFtAc	┬┐Tienes problemas de digesti├│n? ┬íAqu├¡ te muestro una GRAN soluci├│n!| Vanessa Navarro	30	2025	3705	18	0.00	10	0	2025-11-15 10:55:50.079696	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	30	2025	1334	20	0.00	6	0	2025-11-15 10:55:50.079696	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	30	2025	485	5	0.00	0	0	2025-11-15 10:55:50.079696	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	30	2025	391	13	0.00	6	0	2025-11-15 10:55:50.079696	1
uGRrZ7eMlXk	Aprende a dominar tu cuerpo y mente en la menopausia| Vanessa Navarro	30	2025	312	1	0.00	2	0	2025-11-15 10:55:50.079696	1
pzLdKj29hwE	Esta infusi├│n te va a sorprender con sus beneficios ´┐╝| Vanessa Navarro	30	2025	305	1	0.00	0	0	2025-11-15 10:55:50.079696	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	30	2025	197	2	0.00	0	0	2025-11-15 10:55:50.079696	1
3BkN0Kluo6o	Un enemigo silencioso en tu cocina: la verdad sobre las esponjas | Vanessa Navarro	30	2025	175	1	0.00	0	0	2025-11-15 10:55:50.079696	1
duYM658lO8s	ESTO NO LO CONOC├ìAS: Descubre los sorprendentes beneficios de la miel de abejas | Vanessa Navarro	30	2025	175	1	0.00	0	0	2025-11-15 10:55:50.079696	1
oAVveXh_8Qw	Hackea tu biolog├¡a: el poder del biohacking para transformar tu cuerpo y tu mente | Vanessa Navarro	30	2025	166	1	0.00	0	0	2025-11-15 10:55:50.079696	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	31	2025	1623	24	0.00	8	0	2025-11-15 10:56:26.703445	1
nFOHOVcZBck	Jugo para mejorar la digesti├│n| Vanessa Navarro	31	2025	1359	8	0.00	4	0	2025-11-15 10:56:26.703445	1
loA_CqhuQOo	Beber esto durante tu ayuno intermitente potencia sus beneficios ­ƒÆº­ƒìï | Vanessa Navarro	31	2025	921	10	0.00	4	0	2025-11-15 10:56:26.703445	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	31	2025	648	6	0.00	0	0	2025-11-15 10:56:26.703445	1
om4N1brZgnA	Prepara este delicioso pan de banano y ar├índanos: saludable, f├ícil y sin culpa | Vanessa Navarro	31	2025	621	1	0.00	0	0	2025-11-15 10:56:26.703445	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	31	2025	459	15	0.00	5	0	2025-11-15 10:56:26.703445	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	31	2025	215	5	0.00	8	0	2025-11-15 10:56:26.703445	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	31	2025	174	1	0.00	0	0	2025-11-15 10:56:26.703445	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	31	2025	102	1	0.00	0	0	2025-11-15 10:56:26.703445	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	31	2025	95	1	0.00	1	0	2025-11-15 10:56:26.703445	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	32	2025	1579	25	0.00	7	0	2025-11-15 10:57:05.219636	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	32	2025	674	22	0.00	6	0	2025-11-15 10:57:05.219636	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	32	2025	598	7	0.00	0	0	2025-11-15 10:57:05.219636	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	32	2025	228	5	0.00	3	0	2025-11-15 10:57:05.219636	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	32	2025	187	2	0.00	0	0	2025-11-15 10:57:05.219636	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	32	2025	151	1	0.00	0	0	2025-11-15 10:57:05.219636	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	32	2025	122	1	0.00	0	0	2025-11-15 10:57:05.219636	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	32	2025	116	1	0.00	0	0	2025-11-15 10:57:05.219636	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	32	2025	101	1	0.00	0	0	2025-11-15 10:57:05.219636	1
nFOHOVcZBck	Jugo para mejorar la digesti├│n| Vanessa Navarro	32	2025	74	1	0.00	0	0	2025-11-15 10:57:05.219636	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	33	2025	1609	27	0.00	8	0	2025-11-15 10:57:31.535673	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	33	2025	498	18	0.00	13	0	2025-11-15 10:57:31.535673	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	33	2025	493	6	0.00	1	0	2025-11-15 10:57:31.535673	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	33	2025	168	1	0.00	0	0	2025-11-15 10:57:31.535673	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	33	2025	153	1	0.00	0	0	2025-11-15 10:57:31.535673	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	33	2025	152	3	0.00	3	0	2025-11-15 10:57:31.535673	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	33	2025	119	1	0.00	0	0	2025-11-15 10:57:31.535673	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	33	2025	107	1	0.00	0	0	2025-11-15 10:57:31.535673	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	33	2025	101	1	0.00	0	0	2025-11-15 10:57:31.535673	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	33	2025	88	1	0.00	2	0	2025-11-15 10:57:31.535673	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	34	2025	1639	24	0.00	3	0	2025-11-15 10:57:54.294287	1
BkfdAtdq7mg	Tomar caf├® al despertar Ôÿò´©Å puede ser un error: 3 biohacks para hacerlo bien | Vanessa Navarro	34	2025	906	16	0.00	3	0	2025-11-15 10:57:54.294287	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	34	2025	858	9	0.00	1	0	2025-11-15 10:57:54.294287	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	34	2025	452	17	0.00	6	0	2025-11-15 10:57:54.294287	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	34	2025	260	2	0.00	0	0	2025-11-15 10:57:54.294287	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	34	2025	174	1	0.00	0	0	2025-11-15 10:57:54.294287	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	34	2025	123	1	0.00	1	0	2025-11-15 10:57:54.294287	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	34	2025	109	1	0.00	0	0	2025-11-15 10:57:54.294287	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	34	2025	108	1	0.00	1	0	2025-11-15 10:57:54.294287	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	35	2025	1782	26	0.00	10	0	2025-11-15 10:58:28.227009	1
wIdbvkEM-zc	Beneficios de las nueces y cu├íles comer?| Vanessa Navarro	35	2025	1337	7	0.00	3	0	2025-11-15 10:58:28.227009	1
qGnSo_qJrYc	Papel aluminio: el error silencioso en tu cocina que afecta tu salud | Vanessa Navarro	35	2025	1149	5	0.00	2	0	2025-11-15 10:58:28.227009	1
rsIsL6GvBxg	Un pu├▒ado de nueces al d├¡a puede marcar la diferencia ­ƒÑ£Ô£¿| Vanessa Navarro	35	2025	984	5	0.00	2	0	2025-11-15 10:58:28.227009	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	35	2025	771	8	0.00	0	0	2025-11-15 10:58:28.227009	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	35	2025	430	4	0.00	1	0	2025-11-15 10:58:28.227009	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	35	2025	421	15	0.00	3	0	2025-11-15 10:58:28.227009	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	35	2025	178	2	0.00	0	0	2025-11-15 10:58:28.227009	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	35	2025	134	2	0.00	0	0	2025-11-15 10:58:28.227009	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	35	2025	108	1	0.00	0	0	2025-11-15 10:58:28.227009	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	36	2025	1623	23	0.00	7	0	2025-11-15 10:59:05.042356	1
LA3F40RC3G8	Controla tus antojos de dulce y de az├║car con estos tres BioHacks #tips #vanenavarrotv	36	2025	1543	12	0.00	8	0	2025-11-15 10:59:05.042356	1
Ecka5JdI4E0	iohack con canela: estabiliza tu glucosa y acelera tu metabolismo | Vanessa Navarro	36	2025	1236	9	0.00	3	0	2025-11-15 10:59:05.042356	1
-Vrc1Eh9dO8	Smoothie detox verde para energ├¡a y bienestar | Vanessa Navarro	36	2025	1113	8	0.00	5	0	2025-11-15 10:59:05.042356	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	36	2025	918	9	0.00	1	0	2025-11-15 10:59:05.042356	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	36	2025	354	13	0.00	10	0	2025-11-15 10:59:05.042356	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	36	2025	279	2	0.00	0	0	2025-11-15 10:59:05.042356	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	36	2025	170	1	0.00	0	0	2025-11-15 10:59:05.042356	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	36	2025	147	1	0.00	1	0	2025-11-15 10:59:05.042356	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	36	2025	131	1	0.00	0	0	2025-11-15 10:59:05.042356	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	37	2025	1305	19	0.00	7	0	2025-11-15 10:59:34.324789	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	37	2025	816	9	0.00	3	0	2025-11-15 10:59:34.324789	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	37	2025	324	11	0.00	9	0	2025-11-15 10:59:34.324789	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	37	2025	263	2	0.00	0	0	2025-11-15 10:59:34.324789	1
XaZRWi7UitI	5X5 desintoxicaci├│n extrema | Vanessa Navarro	37	2025	178	9	0.00	3	0	2025-11-15 10:59:34.324789	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	37	2025	162	1	0.00	0	0	2025-11-15 10:59:34.324789	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	37	2025	155	1	0.00	0	0	2025-11-15 10:59:34.324789	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	37	2025	147	2	0.00	0	0	2025-11-15 10:59:34.324789	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	37	2025	132	2	0.00	1	0	2025-11-15 10:59:34.324789	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	37	2025	130	1	0.00	0	0	2025-11-15 10:59:34.324789	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	38	2025	728	8	0.00	3	0	2025-11-15 10:59:57.537913	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	38	2025	691	10	0.00	1	0	2025-11-15 10:59:57.537913	1
axMbWGd3XeQ	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	38	2025	474	98	0.00	6	0	2025-11-15 10:59:57.537913	1
bQwFenVSSbg	┬┐Cansado de la caspa? ┬íTenemos un remedio casero s├║per f├ícil para ti! ­ƒìïÔ£¿| Vanessa Navarro	38	2025	407	4	0.00	0	0	2025-11-15 10:59:57.537913	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	38	2025	375	11	0.00	4	0	2025-11-15 10:59:57.537913	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	38	2025	248	2	0.00	0	0	2025-11-15 10:59:57.537913	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	38	2025	213	2	0.00	1	0	2025-11-15 10:59:57.537913	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	38	2025	147	2	0.00	1	0	2025-11-15 10:59:57.537913	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	38	2025	139	1	0.00	0	0	2025-11-15 10:59:57.537913	1
XaZRWi7UitI	5X5 desintoxicaci├│n extrema | Vanessa Navarro	38	2025	108	5	0.00	2	0	2025-11-15 10:59:57.537913	1
ckHb1wn-7Qw	Infusi├│n clavos de olor para dormir| Vanessa Navarro	39	2025	1310	15	0.00	6	0	2025-11-15 11:00:19.071281	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	39	2025	895	13	0.00	1	0	2025-11-15 11:00:19.071281	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	39	2025	800	8	0.00	0	0	2025-11-15 11:00:19.071281	1
axMbWGd3XeQ	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	39	2025	592	164	0.00	13	0	2025-11-15 11:00:19.071281	1
6cPGOVUqAw4	­ƒÄºM├║sica para estudiar, trabajar, relajarse y meditar | Ondas Binaurales 11Hz - Alpha & Theta Waves	39	2025	370	70	0.00	5	0	2025-11-15 11:00:19.071281	1
-ToljWjCLUg	Mayonesa de aguacate saludable y deliciosa | Vanessa Navarro	39	2025	340	4	0.00	6	0	2025-11-15 11:00:19.071281	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	39	2025	269	9	0.00	3	0	2025-11-15 11:00:19.071281	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	39	2025	241	2	0.00	0	0	2025-11-15 11:00:19.071281	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	39	2025	179	2	0.00	0	0	2025-11-15 11:00:19.071281	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	39	2025	147	1	0.00	2	0	2025-11-15 11:00:19.071281	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	40	2025	612	6	0.00	0	0	2025-11-15 11:01:12.263373	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	40	2025	599	9	0.00	3	0	2025-11-15 11:01:12.263373	1
UiaHoFWpXWg	M├║sica BINAURAL para concentrarse, estudiar, trabajar y relajarse | Ondas Alpha 11Hz & Theta 4Hz	40	2025	428	54	0.00	4	0	2025-11-15 11:01:12.263373	1
jnYZ-Pb1dY0	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	40	2025	362	67	0.00	4	0	2025-11-15 11:01:12.263373	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	40	2025	305	2	0.00	0	0	2025-11-15 11:01:12.263373	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	40	2025	247	9	0.00	3	0	2025-11-15 11:01:12.263373	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	40	2025	179	2	0.00	0	0	2025-11-15 11:01:12.263373	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	40	2025	166	1	0.00	0	0	2025-11-15 11:01:12.263373	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	40	2025	163	3	0.00	1	0	2025-11-15 11:01:12.263373	1
6cPGOVUqAw4	­ƒÄºM├║sica para estudiar, trabajar, relajarse y meditar | Ondas Binaurales 11Hz - Alpha & Theta Waves	40	2025	141	65	0.00	4	0	2025-11-15 11:01:12.263373	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	41	2025	589	9	0.00	3	0	2025-11-15 11:01:42.953941	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	41	2025	576	7	0.00	1	0	2025-11-15 11:01:42.953941	1
jnYZ-Pb1dY0	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	41	2025	353	141	0.00	11	0	2025-11-15 11:01:42.953941	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	41	2025	238	2	0.00	0	0	2025-11-15 11:01:42.953941	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	41	2025	227	8	0.00	2	0	2025-11-15 11:01:42.953941	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	41	2025	162	2	0.00	0	0	2025-11-15 11:01:42.953941	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	41	2025	145	1	0.00	0	0	2025-11-15 11:01:42.953941	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	41	2025	117	1	0.00	0	0	2025-11-15 11:01:42.953941	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	41	2025	114	1	0.00	0	0	2025-11-15 11:01:42.953941	1
MkoSsb5ZVLw	Infusi├│n para desinflamar | las articulaciones de forma natural y sana| Vanessa Navarro	41	2025	88	1	0.00	0	0	2025-11-15 11:01:42.953941	1
jnYZ-Pb1dY0	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	42	2025	4497	1220	0.00	124	0	2025-11-15 11:02:08.379631	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	42	2025	595	6	0.00	2	0	2025-11-15 11:02:08.379631	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	42	2025	562	8	0.00	2	0	2025-11-15 11:02:08.379631	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	42	2025	199	2	0.00	1	0	2025-11-15 11:02:08.379631	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	42	2025	151	2	0.00	0	0	2025-11-15 11:02:08.379631	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	42	2025	148	5	0.00	0	0	2025-11-15 11:02:08.379631	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	42	2025	133	2	0.00	0	0	2025-11-15 11:02:08.379631	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	42	2025	118	1	0.00	1	0	2025-11-15 11:02:08.379631	1
6cPGOVUqAw4	­ƒÄºM├║sica para estudiar, trabajar, relajarse y meditar | Ondas Binaurales 11Hz - Alpha & Theta Waves	42	2025	109	23	0.00	5	0	2025-11-15 11:02:08.379631	1
ckHb1wn-7Qw	Infusi├│n clavos de olor para dormir| Vanessa Navarro	42	2025	108	2	0.00	0	0	2025-11-15 11:02:08.379631	1
jnYZ-Pb1dY0	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	43	2025	961	650	0.00	9	0	2025-11-15 11:02:31.604331	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	43	2025	413	5	0.00	1	0	2025-11-15 11:02:31.604331	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	43	2025	188	3	0.00	1	0	2025-11-15 11:02:31.604331	1
Ro_OBDbDNMU	­ƒÄºM├║sica para estudiar, trabajar, relajarse y meditar | Ondas Binaurales 11Hz - Alpha & Theta Waves	43	2025	181	30	0.00	4	0	2025-11-15 11:02:31.604331	1
UiaHoFWpXWg	M├║sica BINAURAL para concentrarse, estudiar, trabajar y relajarse | Ondas Alpha 11Hz & Theta 4Hz	43	2025	140	41	0.00	4	0	2025-11-15 11:02:31.604331	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	43	2025	136	5	0.00	1	0	2025-11-15 11:02:31.604331	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	43	2025	125	1	0.00	0	0	2025-11-15 11:02:31.604331	1
h8VYdaDClCs	Sal de oro Ô£¿ la mezcla antiinflamatoria con grandes beneficios para tu salud | Vanessa Navarro	43	2025	65	1	0.00	0	0	2025-11-15 11:02:31.604331	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	43	2025	64	1	0.00	0	0	2025-11-15 11:02:31.604331	1
Ro_OBDbDNMU	­ƒÄºM├║sica para estudiar, trabajar, relajarse y meditar | Ondas Binaurales 11Hz - Alpha & Theta Waves	44	2025	742	186	0.00	15	0	2025-11-15 11:02:58.949008	1
jnYZ-Pb1dY0	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	44	2025	605	457	0.00	6	0	2025-11-15 11:02:58.949008	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	44	2025	416	6	0.00	1	0	2025-11-15 11:02:58.949008	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	44	2025	283	3	0.00	4	0	2025-11-15 11:02:58.949008	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	44	2025	109	1	0.00	1	0	2025-11-15 11:02:58.949008	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	44	2025	86	1	0.00	1	0	2025-11-15 11:02:58.949008	1
UiaHoFWpXWg	M├║sica BINAURAL para concentrarse, estudiar, trabajar y relajarse | Ondas Alpha 11Hz & Theta 4Hz	44	2025	81	22	0.00	2	0	2025-11-15 11:02:58.949008	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	44	2025	78	3	0.00	1	0	2025-11-15 11:02:58.949008	1
ckHb1wn-7Qw	Infusi├│n clavos de olor para dormir| Vanessa Navarro	44	2025	64	2	0.00	0	0	2025-11-15 11:02:58.949008	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	44	2025	61	1	0.00	0	0	2025-11-15 11:02:58.949008	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	45	2025	577	8	0.00	0	0	2025-11-15 11:03:27.173683	1
jnYZ-Pb1dY0	M├║sica para Dormir Profundamente, Meditar y Aliviar la Ansiedad | Ondas Theta 4 Hz Binaurales	45	2025	529	426	0.00	5	0	2025-11-15 11:03:27.173683	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	45	2025	228	3	0.00	1	0	2025-11-15 11:03:27.173683	1
Ro_OBDbDNMU	­ƒÄºM├║sica para estudiar, trabajar, relajarse y meditar | Ondas Binaurales 11Hz - Alpha & Theta Waves	45	2025	224	82	0.00	6	0	2025-11-15 11:03:27.173683	1
9Uvp7LsFJP0	Infusi├│n de pepa de aguacate: limpia el h├¡gado y ayuda a perder peso ­ƒìâ | Vanessa Navarro	45	2025	148	1	0.00	2	0	2025-11-15 11:03:27.173683	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	45	2025	102	4	0.00	1	0	2025-11-15 11:03:27.173683	1
rK4J6avw8IE	Extracto de alcachofa para bajar el colesterol,  cuidar tu h├¡gado y coraz├│n | Vanessa Navarro	45	2025	75	1	0.00	0	0	2025-11-15 11:03:27.173683	1
5yhXD6hPpl8	Antia para las ├║lceras g├ístricas, jugo de repollo morado | Vanessa Navarro	45	2025	68	1	0.00	0	0	2025-11-15 11:03:27.173683	1
QHiOVTA7-n4	Jugo de alcachofa para limpiar el h├¡gado  | Detox natural y delicioso | Vanessa Navarro	45	2025	68	1	0.00	0	0	2025-11-15 11:03:27.173683	1
ZkNwyefHeT4	POLVO DE C├üSCARA DE NARANJA | Vanessa Navarro	45	2025	56	2	0.00	0	0	2025-11-15 11:03:27.173683	1
qdVlZjSNbR0	Un gran prop├│sito para este a├▒o: dile adi├│s a esta bebida ­ƒÜ½­ƒÑñ | Vanessa Navarro	2	2025	483	4	0.00	2	0	2025-11-15 11:04:08.399842	1
8q7uo6RZa_Y	Batido de ch├¡a y linaza: digestivo, desintoxicante y energizante ­ƒî┐ | Vanessa Navarro	2	2025	65	1	0.00	1	0	2025-11-14 15:35:08.726954	1
UJu16U5DCFk	Es hora de desintoxicar tu organismo con este jugo verde ­ƒî┐­ƒÆÜ | Vanessa Navarro	2	2025	26	0	0.00	0	0	2025-11-14 15:35:08.726954	1
KA-jSRCXPiM	COMO PREPARAR GOMITAS ANTI-ENVEJECIMIENTO RICAS EN COLAGENO DELICIOSAS Y NATURALES| Vanessa Navarro	2	2025	19	1	0.00	0	0	2025-11-14 15:35:08.726954	1
sqHjDz5jvZc	Jugo rico en Resveratrol: El antioxidante mas PODEROSO | Vanessa Navarro	2	2025	13	0	0.00	2	0	2025-11-14 15:35:08.726954	1
MWArBcArscA	MANOS DE PORCELANA | Vanessa Navarro	2	2025	8	0	0.00	0	0	2025-11-14 15:35:08.726954	1
2ElDFV3Slg4	JUGO PARA EVITAR LA CA├ìDA DE CABELLO | Vanessa Navarro	2	2025	4	0	0.00	0	0	2025-11-15 11:04:08.399842	1
Lqnb-K1xEWM	Jugo para fortalecer el sistema inmunol├│gico | mant├®n tus defensas fuertes | Vanessa Navarro	2	2025	4	0	0.00	0	0	2025-11-15 11:04:08.399842	1
ajQRNokEL9g	Un secreto ancestral de bienestar y salud| Vanessa Navarro	2	2025	4	0	0.00	0	0	2025-11-15 11:04:08.399842	1
dLjcLEGglek	Tortillas de linaza: receta saludable y f├ícil | Vanessa Navarro	2	2025	4	0	0.00	0	0	2025-11-15 11:04:08.399842	1
\.


--
-- Data for Name: usuario_subcuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_subcuenta (id_usuario, id_subcuenta) FROM stdin;
1	1
2	1
\.


--
-- Name: dim_cuenta_id_cuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_cuenta_id_cuenta_seq', 2, true);


--
-- Name: dim_meta_subcuenta_id_meta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_meta_subcuenta_id_meta_seq', 12, true);


--
-- Name: dim_subcuenta_id_subcuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_subcuenta_id_subcuenta_seq', 2, true);


--
-- Name: dim_usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_usuario_id_usuario_seq', 3, true);


--
-- Name: dim_cuenta dim_cuenta_nombre_cuenta_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cuenta
    ADD CONSTRAINT dim_cuenta_nombre_cuenta_key UNIQUE (nombre_cuenta);


--
-- Name: dim_cuenta dim_cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cuenta
    ADD CONSTRAINT dim_cuenta_pkey PRIMARY KEY (id_cuenta);


--
-- Name: dim_meta_subcuenta dim_meta_subcuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_meta_subcuenta
    ADD CONSTRAINT dim_meta_subcuenta_pkey PRIMARY KEY (id_meta);


--
-- Name: dim_subcuenta dim_subcuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_subcuenta
    ADD CONSTRAINT dim_subcuenta_pkey PRIMARY KEY (id_subcuenta);


--
-- Name: dim_usuario dim_usuario_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_usuario
    ADD CONSTRAINT dim_usuario_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- Name: dim_usuario dim_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_usuario
    ADD CONSTRAINT dim_usuario_pkey PRIMARY KEY (id_usuario);


--
-- Name: fact_channel_daily_metrics fact_channel_daily_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_channel_daily_metrics
    ADD CONSTRAINT fact_channel_daily_metrics_pkey PRIMARY KEY (date, id_subcuenta);


--
-- Name: fact_video_weekly_metrics fact_video_weekly_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_video_weekly_metrics
    ADD CONSTRAINT fact_video_weekly_metrics_pkey PRIMARY KEY (video_id, week, year, id_subcuenta);


--
-- Name: usuario_subcuenta usuario_subcuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_subcuenta
    ADD CONSTRAINT usuario_subcuenta_pkey PRIMARY KEY (id_usuario, id_subcuenta);


--
-- Name: fact_channel_daily_metrics fk_channel_subcuenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_channel_daily_metrics
    ADD CONSTRAINT fk_channel_subcuenta FOREIGN KEY (id_subcuenta) REFERENCES public.dim_subcuenta(id_subcuenta) ON DELETE CASCADE;


--
-- Name: dim_meta_subcuenta fk_meta_subcuenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_meta_subcuenta
    ADD CONSTRAINT fk_meta_subcuenta FOREIGN KEY (id_subcuenta) REFERENCES public.dim_subcuenta(id_subcuenta) ON DELETE CASCADE;


--
-- Name: dim_subcuenta fk_subcuenta_cuenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_subcuenta
    ADD CONSTRAINT fk_subcuenta_cuenta FOREIGN KEY (id_cuenta) REFERENCES public.dim_cuenta(id_cuenta) ON DELETE CASCADE;


--
-- Name: fact_video_weekly_metrics fk_video_subcuenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_video_weekly_metrics
    ADD CONSTRAINT fk_video_subcuenta FOREIGN KEY (id_subcuenta) REFERENCES public.dim_subcuenta(id_subcuenta) ON DELETE CASCADE;


--
-- Name: usuario_subcuenta usuario_subcuenta_id_subcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_subcuenta
    ADD CONSTRAINT usuario_subcuenta_id_subcuenta_fkey FOREIGN KEY (id_subcuenta) REFERENCES public.dim_subcuenta(id_subcuenta) ON DELETE CASCADE;


--
-- Name: usuario_subcuenta usuario_subcuenta_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_subcuenta
    ADD CONSTRAINT usuario_subcuenta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.dim_usuario(id_usuario) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict YZGG7xMCPWF0jzXSF2jJsMU3Io9Mwn666UYVMHPL3DwUrCJmF4tv9GEBEh0ylKw

