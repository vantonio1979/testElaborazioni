--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 16.1

-- Started on 2024-01-05 15:43:26

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
-- TOC entry 1585 (class 1259 OID 44671)
-- Name: anagraficaElaborazioni; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."anagraficaElaborazioni" (
    id integer NOT NULL,
    "codiceElab" text,
    "codProcesso" text,
    "codAnno" text,
    "codPeriodo" text,
    "codAmbiente" text,
    "codUtenteInserimento" text,
    "dataInserimento" date,
    "dataModifica" date,
    "profiloUtente" text,
    cruscotto text,
    codjob text,
    "codEntity" text,
    "codDescription" text,
    key1 text,
    key2 text,
    key3 text
);


ALTER TABLE public."anagraficaElaborazioni" OWNER TO postgres;

--
-- TOC entry 1586 (class 1259 OID 44674)
-- Name: anagraficaElaborazioni_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."anagraficaElaborazioni_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."anagraficaElaborazioni_id_seq" OWNER TO postgres;

--
-- TOC entry 7639 (class 0 OID 0)
-- Dependencies: 1586
-- Name: anagraficaElaborazioni_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."anagraficaElaborazioni_id_seq" OWNED BY public."anagraficaElaborazioni".id;


--
-- TOC entry 7451 (class 2604 OID 44675)
-- Name: anagraficaElaborazioni id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."anagraficaElaborazioni" ALTER COLUMN id SET DEFAULT nextval('public."anagraficaElaborazioni_id_seq"'::regclass);


--
-- TOC entry 7632 (class 0 OID 44671)
-- Dependencies: 1585
-- Data for Name: anagraficaElaborazioni; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."anagraficaElaborazioni" (id, "codiceElab", "codProcesso", "codAnno", "codPeriodo", "codAmbiente", "codUtenteInserimento", "dataInserimento", "dataModifica", "profiloUtente", cruscotto, codjob, "codEntity", "codDescription", key1, key2, key3) VALUES (1, 'aae', 'ACT_TEST_2 - null', '2017TEST_2 - 2017TEST_2', '01 - January', '01', '01', '2023-12-28', '2023-12-28', 'User', 'Contributor', 'T5', 'EN_00', 'Depreciation', 'AmmortizzamentoAziendeRunner', 'AmmortizzamentoAziendeRunnerJob', 'AmmortizzamentoAziendeRunnerWorkflow');
INSERT INTO public."anagraficaElaborazioni" (id, "codiceElab", "codProcesso", "codAnno", "codPeriodo", "codAmbiente", "codUtenteInserimento", "dataInserimento", "dataModifica", "profiloUtente", cruscotto, codjob, "codEntity", "codDescription", key1, key2, key3) VALUES (2, 'ane', 'ACT_TEST_2 - null', '2017TEST_2 - 2017TEST_2', '01 - January', '01', '01', '2024-01-04', '2024-01-04', 'User', 'Consolidator', 'T8', 'EN_100', 'Group data processing', 'AmmortizzamentoNodiElaboration', 'AmmortamentoNodiElaborationJob', 'AmmortizzamentoNodiElaborationWorkFlow');


--
-- TOC entry 7640 (class 0 OID 0)
-- Dependencies: 1586
-- Name: anagraficaElaborazioni_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."anagraficaElaborazioni_id_seq"', 1, false);


-- Completed on 2024-01-05 15:43:26

--
-- PostgreSQL database dump complete
--

