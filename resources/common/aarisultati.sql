--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 16.1

-- Started on 2024-01-05 15:40:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- TOC entry 1636 (class 1259 OID 45921)
-- Name: aarisultati; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aarisultati (
    id integer NOT NULL,
    "codiceElab" text,
    "tipoElab" integer,
    eseguitoda text,
    risultato integer,
    "dataInserimento" timestamp with time zone
);


ALTER TABLE public.aarisultati OWNER TO postgres;

--
-- TOC entry 1635 (class 1259 OID 45920)
-- Name: aarisultati_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aarisultati_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aarisultati_id_seq OWNER TO postgres;

--
-- TOC entry 7641 (class 0 OID 0)
-- Dependencies: 1635
-- Name: aarisultati_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aarisultati_id_seq OWNED BY public.aarisultati.id;


--
-- TOC entry 7451 (class 2604 OID 45924)
-- Name: aarisultati id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aarisultati ALTER COLUMN id SET DEFAULT nextval('public.aarisultati_id_seq'::regclass);


--
-- TOC entry 7635 (class 0 OID 45921)
-- Dependencies: 1636
-- Data for Name: aarisultati; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (1, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, NULL);
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (2, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-03 12:37:46.084+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (3, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-03 12:39:27.068+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (4, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-03 12:41:39.897+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (5, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-04 10:24:25.08+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (6, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-04 15:55:06.02+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (7, 'ACT_TEST - null', 0, 'A.VORRARO', 1, '2024-01-04 15:55:06.02+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (8, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-04 15:57:25.066+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (9, 'ACT_TEST - null', 0, 'A.VORRARO', 1, '2024-01-04 15:57:25.066+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (10, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-04 15:58:52.798+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (11, 'ACT_TEST - null', 0, 'A.VORRARO', 1, '2024-01-04 15:58:52.798+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (12, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-04 16:00:15.008+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (13, 'ACT_TEST - null', 0, 'A.VORRARO', 1, '2024-01-04 16:00:15.008+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (14, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-04 16:08:31.408+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (15, 'ACT_TEST - null', 0, 'A.VORRARO', 1, '2024-01-04 16:08:31.408+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (16, 'ACT_TEST_2 - null', 0, 'A.VORRARO', 1, '2024-01-04 16:10:24.216+00');
INSERT INTO public.aarisultati (id, "codiceElab", "tipoElab", eseguitoda, risultato, "dataInserimento") VALUES (17, 'ACT_TEST - null', 0, 'A.VORRARO', 1, '2024-01-04 16:10:24.216+00');


--
-- TOC entry 7642 (class 0 OID 0)
-- Dependencies: 1635
-- Name: aarisultati_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aarisultati_id_seq', 17, true);


--
-- TOC entry 7453 (class 2606 OID 45928)
-- Name: aarisultati aarisultati_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aarisultati
    ADD CONSTRAINT aarisultati_pkey PRIMARY KEY (id);


-- Completed on 2024-01-05 15:40:50

--
-- PostgreSQL database dump complete
--

