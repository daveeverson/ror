CREATE TABLE public.tribal_contact_units
(
  name character varying(100),
  abbr character varying(100)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.tribal_contact_units
  OWNER TO postgres;

CREATE TABLE public.tribal_contacts
(
  topic character varying(100),
  tribal_contact_first_name character varying(100),
  tribal_contact_last_name character varying(100),
  staff_first_name character varying(100),
  staff_last_name character varying(100),
  contact_date date,
  unit_id integer,
  tribal_entity_id integer,
  author_id integer,
  created_at time without time zone,
  notes text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.tribal_contacts
  OWNER TO postgres;

CREATE TABLE public.tribal_entities
(
  name character varying(100),
  id integer NOT NULL,
  CONSTRAINT tribal_entities_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.tribal_entities
  OWNER TO postgres;

CREATE TABLE public.tribal_entity
(
  id integer NOT NULL,
  CONSTRAINT pk1 PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.tribal_entity
  OWNER TO postgres;

