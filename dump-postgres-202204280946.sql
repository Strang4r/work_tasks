--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-28 09:46:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'WIN1250';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 16460)
-- Name: balance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.balance (
    dollar_balance double precision NOT NULL,
    client_id integer
);


ALTER TABLE public.balance OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16452)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16451)
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_id_seq OWNER TO postgres;

--
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 210
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- TOC entry 214 (class 1259 OID 16497)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    client_id integer,
    balance_change double precision NOT NULL,
    added_to_queue_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    transaction_time timestamp without time zone,
    approved boolean
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16496)
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_transaction_id_seq OWNER TO postgres;

--
-- TOC entry 3334 (class 0 OID 0)
-- Dependencies: 213
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- TOC entry 3174 (class 2604 OID 16455)
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- TOC entry 3175 (class 2604 OID 16500)
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- TOC entry 3324 (class 0 OID 16460)
-- Dependencies: 212
-- Data for Name: balance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.balance (dollar_balance, client_id) FROM stdin;
1000	1
700	2
\.


--
-- TOC entry 3323 (class 0 OID 16452)
-- Dependencies: 211
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, name) FROM stdin;
1	Frank
2	Greg
\.


--
-- TOC entry 3326 (class 0 OID 16497)
-- Dependencies: 214
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (transaction_id, client_id, balance_change, added_to_queue_time, transaction_time, approved) FROM stdin;
3	2	-1000	2022-04-27 18:13:52.174976	2022-04-28 08:46:39.716755	t
4	2	-1000	2022-04-27 18:19:04.277409	2022-04-28 08:46:39.71793	t
5	2	-1000	2022-04-27 18:19:10.255475	2022-04-28 08:46:39.719106	t
6	1	-100000	2022-04-27 18:29:41.323546	2022-04-28 08:46:39.720398	f
7	1	-10000	2022-04-27 18:32:58.379039	2022-04-28 08:46:39.721555	f
8	1	-20000	2022-04-27 18:32:58.381193	2022-04-28 08:46:39.722633	f
9	1	2000	2022-04-27 18:32:58.382176	2022-04-28 08:46:39.723675	t
10	1	5000	2022-04-27 18:32:58.382817	2022-04-28 08:46:39.724848	t
11	2	-50000	2022-04-27 18:32:58.383299	2022-04-28 08:46:39.72608	f
12	2	500	2022-04-27 18:32:58.383771	2022-04-28 08:46:39.727098	t
13	2	900	2022-04-27 18:32:58.384306	2022-04-28 08:46:39.728261	t
14	1	1000	2022-04-27 18:37:31.020164	2022-04-28 08:46:39.72945	t
15	1	2000	2022-04-27 18:37:31.022517	2022-04-28 08:46:39.730628	t
16	1	2000	2022-04-27 18:37:31.02325	2022-04-28 08:46:39.731877	t
17	1	5000	2022-04-27 18:37:31.023977	2022-04-28 08:46:39.733166	t
18	2	1000	2022-04-27 18:37:31.024651	2022-04-28 08:46:39.734359	t
19	2	500	2022-04-27 18:37:31.02542	2022-04-28 08:46:39.735529	t
20	2	900	2022-04-27 18:37:31.026465	2022-04-28 08:46:39.736793	t
21	1	-1000	2022-04-28 08:39:41.739301	2022-04-28 08:46:39.738224	t
22	1	-2000	2022-04-28 08:39:41.744772	2022-04-28 08:46:39.739566	t
23	1	-2000	2022-04-28 08:39:41.745741	2022-04-28 08:46:39.740832	t
24	1	-5000	2022-04-28 08:39:41.746931	2022-04-28 08:46:40.101731	t
25	2	1000	2022-04-28 08:39:41.747731	2022-04-28 08:46:40.103135	t
26	2	-500	2022-04-28 08:39:41.74866	2022-04-28 08:46:40.104374	t
27	2	-9000	2022-04-28 08:39:41.749537	2022-04-28 08:46:40.105473	f
28	1	-1000	2022-04-28 08:40:10.256216	2022-04-28 08:46:40.106497	t
29	1	-2000	2022-04-28 08:40:10.259039	2022-04-28 08:46:40.107635	t
30	1	-2000	2022-04-28 08:40:10.260293	2022-04-28 08:46:40.108786	t
31	1	-5000	2022-04-28 08:40:10.261193	2022-04-28 08:46:40.109755	f
32	2	1000	2022-04-28 08:40:10.262315	2022-04-28 08:46:40.110553	t
33	2	-500	2022-04-28 08:40:10.263182	2022-04-28 08:46:40.111769	t
34	2	-9000	2022-04-28 08:40:10.264052	2022-04-28 08:46:40.112901	t
35	1	-1000	2022-04-28 08:45:30.361955	2022-04-28 08:46:40.113843	t
36	1	-2000	2022-04-28 08:45:30.364671	2022-04-28 08:46:40.114738	f
37	1	-2000	2022-04-28 08:45:30.365672	2022-04-28 08:46:40.115524	f
38	1	-5000	2022-04-28 08:45:30.366593	2022-04-28 08:46:40.116514	f
39	2	1000	2022-04-28 08:45:30.367686	2022-04-28 08:46:40.117348	t
40	2	-500	2022-04-28 08:45:30.368575	2022-04-28 08:46:40.118285	t
41	2	-9000	2022-04-28 08:45:30.369583	2022-04-28 08:46:40.11927	f
62	2	0	2022-04-28 08:49:26.494753	2022-04-28 08:49:26.545809	t
42	1	-1000	2022-04-28 08:46:20.834446	2022-04-28 08:46:39.704096	t
43	1	-2000	2022-04-28 08:46:20.836689	2022-04-28 08:46:39.70764	f
44	1	-2000	2022-04-28 08:46:20.83736	2022-04-28 08:46:39.708706	f
45	1	-5000	2022-04-28 08:46:20.838133	2022-04-28 08:46:39.70976	f
46	2	1000	2022-04-28 08:46:20.838774	2022-04-28 08:46:39.710768	t
47	2	-500	2022-04-28 08:46:20.839387	2022-04-28 08:46:39.711975	t
48	2	-9000	2022-04-28 08:46:20.839994	2022-04-28 08:46:39.713185	f
1	1	-1000	2022-04-27 17:48:14.680025	2022-04-28 08:46:39.714257	f
2	2	-1000	2022-04-27 18:07:01.691785	2022-04-28 08:46:39.715474	t
49	1	0	2022-04-28 08:47:23.622919	2022-04-28 08:47:23.665066	t
50	1	0	2022-04-28 08:47:23.625335	2022-04-28 08:47:23.668278	t
51	1	0	2022-04-28 08:47:23.626253	2022-04-28 08:47:23.670093	t
52	1	0	2022-04-28 08:47:23.627166	2022-04-28 08:47:23.671422	t
53	2	0	2022-04-28 08:47:23.628103	2022-04-28 08:47:23.673089	t
54	2	0	2022-04-28 08:47:23.629138	2022-04-28 08:47:23.674646	t
55	2	0	2022-04-28 08:47:23.630028	2022-04-28 08:47:23.675916	t
56	1	0	2022-04-28 08:49:26.487753	2022-04-28 08:49:26.534286	t
57	1	0	2022-04-28 08:49:26.49041	2022-04-28 08:49:26.537351	t
58	1	0	2022-04-28 08:49:26.491311	2022-04-28 08:49:26.539052	t
59	1	0	2022-04-28 08:49:26.492106	2022-04-28 08:49:26.541193	t
60	2	0	2022-04-28 08:49:26.492934	2022-04-28 08:49:26.543518	t
61	2	0	2022-04-28 08:49:26.493743	2022-04-28 08:49:26.544685	t
\.


--
-- TOC entry 3335 (class 0 OID 0)
-- Dependencies: 210
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 1, false);


--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 213
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 62, true);


--
-- TOC entry 3178 (class 2606 OID 16459)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 3180 (class 2606 OID 16503)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 3181 (class 2606 OID 16463)
-- Name: balance balance_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance
    ADD CONSTRAINT balance_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3182 (class 2606 OID 16504)
-- Name: transactions transactions_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);


-- Completed on 2022-04-28 09:46:14

--
-- PostgreSQL database dump complete
--

