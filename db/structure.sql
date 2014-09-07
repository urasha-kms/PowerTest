--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ut_test_answ; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_answ (
    id_answ integer NOT NULL,
    id_db_answ integer NOT NULL,
    id_quest integer NOT NULL,
    iddb_quest integer NOT NULL,
    text text,
    good integer NOT NULL
);


--
-- Name: ut_test_category; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_category (
    id_category integer NOT NULL,
    name text,
    short text,
    id_parent integer,
    namepropis text
);


--
-- Name: ut_test_category_percent; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_category_percent (
    id_category_percent integer NOT NULL,
    id_category_main integer NOT NULL,
    id_category integer NOT NULL,
    percent integer NOT NULL,
    id_topic integer NOT NULL
);


--
-- Name: ut_test_numticket; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_numticket (
    id_numticket integer NOT NULL,
    id_category integer NOT NULL,
    nticket integer NOT NULL,
    id_topic integer NOT NULL
);


--
-- Name: ut_test_quest; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_quest (
    id_quest integer NOT NULL,
    id_db_quest integer NOT NULL,
    id_topic integer NOT NULL,
    id_category integer NOT NULL,
    text text
);


--
-- Name: ut_test_schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: ut_test_ticket; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_ticket (
    id_numticket integer NOT NULL,
    id_quest integer NOT NULL,
    iddb_quest integer NOT NULL,
    num integer NOT NULL
);


--
-- Name: ut_test_topic; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_topic (
    id_topic integer NOT NULL,
    name text,
    short text,
    countmonth integer NOT NULL
);


--
-- Name: ut_test_user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ut_test_user (
    id_user integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    remember_token text NOT NULL,
    admin integer DEFAULT 0 NOT NULL,
    date_start date,
    date_stop date,
    count_session integer DEFAULT 0 NOT NULL,
    password_digest text NOT NULL
);


--
-- Name: ut_test_user_id_user_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ut_test_user_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ut_test_user_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ut_test_user_id_user_seq OWNED BY ut_test_user.id_user;


--
-- Name: id_user; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_user ALTER COLUMN id_user SET DEFAULT nextval('ut_test_user_id_user_seq'::regclass);


--
-- Name: uk_category_main; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_category_percent
    ADD CONSTRAINT uk_category_main UNIQUE (id_category_main, id_category, id_topic);


--
-- Name: uk_numticket_nticket; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_numticket
    ADD CONSTRAINT uk_numticket_nticket UNIQUE (id_topic, id_category, nticket);


--
-- Name: uk_ticket_numticket; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_ticket
    ADD CONSTRAINT uk_ticket_numticket UNIQUE (id_numticket, id_quest, iddb_quest);


--
-- Name: ut_test_answ_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_answ
    ADD CONSTRAINT ut_test_answ_pkey PRIMARY KEY (id_answ, id_db_answ);


--
-- Name: ut_test_category_percent_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_category_percent
    ADD CONSTRAINT ut_test_category_percent_pkey PRIMARY KEY (id_category_percent);


--
-- Name: ut_test_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_category
    ADD CONSTRAINT ut_test_category_pkey PRIMARY KEY (id_category);


--
-- Name: ut_test_numticket_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_numticket
    ADD CONSTRAINT ut_test_numticket_pkey PRIMARY KEY (id_numticket);


--
-- Name: ut_test_quest_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_quest
    ADD CONSTRAINT ut_test_quest_pkey PRIMARY KEY (id_quest, id_db_quest);


--
-- Name: ut_test_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_ticket
    ADD CONSTRAINT ut_test_ticket_pkey PRIMARY KEY (id_numticket, id_quest, iddb_quest);


--
-- Name: ut_test_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_topic
    ADD CONSTRAINT ut_test_topic_pkey PRIMARY KEY (id_topic);


--
-- Name: ut_test_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ut_test_user
    ADD CONSTRAINT ut_test_user_pkey PRIMARY KEY (id_user);


--
-- Name: index_ut_test_answ_on_id_quest_and_iddb_quest; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ut_test_answ_on_id_quest_and_iddb_quest ON ut_test_answ USING btree (id_quest, iddb_quest);


--
-- Name: index_ut_test_numticket_on_id_topic_and_id_category; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ut_test_numticket_on_id_topic_and_id_category ON ut_test_numticket USING btree (id_topic, id_category);


--
-- Name: index_ut_test_numticket_on_id_topic_and_id_category_and_nticket; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ut_test_numticket_on_id_topic_and_id_category_and_nticket ON ut_test_numticket USING btree (id_topic, id_category, nticket);


--
-- Name: index_ut_test_quest_on_id_topic_and_id_category; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ut_test_quest_on_id_topic_and_id_category ON ut_test_quest USING btree (id_topic, id_category);


--
-- Name: index_ut_test_ticket_on_id_numticket_and_num; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ut_test_ticket_on_id_numticket_and_num ON ut_test_ticket USING btree (id_numticket, num);


--
-- Name: index_ut_test_user_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_ut_test_user_on_email ON ut_test_user USING btree (email);


--
-- Name: index_ut_test_user_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_ut_test_user_on_name ON ut_test_user USING btree (name);


--
-- Name: index_ut_test_user_on_remember_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_ut_test_user_on_remember_token ON ut_test_user USING btree (remember_token);


--
-- Name: ut_test_unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX ut_test_unique_schema_migrations ON ut_test_schema_migrations USING btree (version);


--
-- Name: fk_answ_quest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_answ
    ADD CONSTRAINT fk_answ_quest FOREIGN KEY (id_quest, iddb_quest) REFERENCES ut_test_quest(id_quest, id_db_quest) ON DELETE CASCADE;


--
-- Name: fk_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_category_percent
    ADD CONSTRAINT fk_category FOREIGN KEY (id_category) REFERENCES ut_test_category(id_category) ON DELETE CASCADE;


--
-- Name: fk_category_main; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_category_percent
    ADD CONSTRAINT fk_category_main FOREIGN KEY (id_category_main) REFERENCES ut_test_category(id_category) ON DELETE CASCADE;


--
-- Name: fk_numticket_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_numticket
    ADD CONSTRAINT fk_numticket_category FOREIGN KEY (id_category) REFERENCES ut_test_category(id_category) ON DELETE CASCADE;


--
-- Name: fk_numticket_topic; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_numticket
    ADD CONSTRAINT fk_numticket_topic FOREIGN KEY (id_topic) REFERENCES ut_test_topic(id_topic) ON DELETE CASCADE;


--
-- Name: fk_quest_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_quest
    ADD CONSTRAINT fk_quest_category FOREIGN KEY (id_category) REFERENCES ut_test_category(id_category) ON DELETE CASCADE;


--
-- Name: fk_quest_topic; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_quest
    ADD CONSTRAINT fk_quest_topic FOREIGN KEY (id_topic) REFERENCES ut_test_topic(id_topic) ON DELETE CASCADE;


--
-- Name: fk_ticket_nticket; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_ticket
    ADD CONSTRAINT fk_ticket_nticket FOREIGN KEY (id_numticket) REFERENCES ut_test_numticket(id_numticket) ON DELETE CASCADE;


--
-- Name: fk_ticket_quest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ut_test_ticket
    ADD CONSTRAINT fk_ticket_quest FOREIGN KEY (id_quest, iddb_quest) REFERENCES ut_test_quest(id_quest, id_db_quest) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130906043533');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130906043612');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130906043627');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130906043652');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130906043718');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130906043739');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130906043811');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130911004038');

INSERT INTO ut_test_schema_migrations (version) VALUES ('20130916002622');

