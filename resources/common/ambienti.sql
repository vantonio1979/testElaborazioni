--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 16.1

-- Started on 2024-01-05 15:42:16

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
-- TOC entry 1588 (class 1259 OID 44682)
-- Name: ambienti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ambienti (
    id integer NOT NULL,
    url text,
    versione text,
    username text,
    password text,
    utenteins text,
    utentemod text,
    datains date,
    datamod date
);


ALTER TABLE public.ambienti OWNER TO postgres;

--
-- TOC entry 1587 (class 1259 OID 44681)
-- Name: ambienti_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ambienti_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ambienti_id_seq OWNER TO postgres;

--
-- TOC entry 7641 (class 0 OID 0)
-- Dependencies: 1587
-- Name: ambienti_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ambienti_id_seq OWNED BY public.ambienti.id;


--
-- TOC entry 7451 (class 2604 OID 44685)
-- Name: ambienti id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambienti ALTER COLUMN id SET DEFAULT nextval('public.ambienti_id_seq'::regclass);


--
-- TOC entry 7635 (class 0 OID 44682)
-- Dependencies: 1588
-- Data for Name: ambienti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ambienti (id, url, versione, username, password, utenteins, utentemod, datains, datamod) VALUES (1, 'https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm', '27', 'A.VORRARO', 'pass', 'A.VORRARO', 'A.VORRARO', '2023-12-28', '2023-12-28');
INSERT INTO public.ambienti (id, url, versione, username, password, utenteins, utentemod, datains, datamod) VALUES (2, 'https://cpm-man-5326-3.platformteam.saastagetik.com/tagetikcpm', '26', 'A.VORRARO', 'pass', 'A.VORRARO', 'A.VORRARO', '2023-12-28', '2023-12-28');


--
-- TOC entry 7642 (class 0 OID 0)
-- Dependencies: 1587
-- Name: ambienti_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ambienti_id_seq', 1, false);


--
-- TOC entry 7453 (class 2606 OID 44689)
-- Name: ambienti ambienti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambienti
    ADD CONSTRAINT ambienti_pkey PRIMARY KEY (id);


-- Completed on 2024-01-05 15:42:16

--
-- PostgreSQL database dump complete
--

