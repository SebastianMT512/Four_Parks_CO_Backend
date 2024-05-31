--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-30 14:29:13 -05

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

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 18718)
-- Name: bill; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bill (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    vehicle_entry timestamp with time zone NOT NULL,
    vehicle_exit timestamp with time zone NOT NULL,
    total_time time without time zone NOT NULL,
    points_used integer,
    total_amount integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    booking_id integer NOT NULL,
    payment_method_id integer NOT NULL,
    deleted_date timestamp with time zone
);


--
-- TOC entry 216 (class 1259 OID 18721)
-- Name: bill_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3794 (class 0 OID 0)
-- Dependencies: 216
-- Name: bill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bill_id_seq OWNED BY public.bill.id;


--
-- TOC entry 217 (class 1259 OID 18722)
-- Name: booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    check_in timestamp with time zone NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone,
    user_id integer NOT NULL,
    parking_id integer NOT NULL,
    vehicle_id integer NOT NULL,
    check_out timestamp with time zone NOT NULL
);


--
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN booking.user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.booking.user_id IS 'Es el usuario que hizo la reserva';


--
-- TOC entry 218 (class 1259 OID 18725)
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 218
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- TOC entry 219 (class 1259 OID 18726)
-- Name: city; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.city (
    id integer NOT NULL,
    city_name character varying(30) NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone
);


--
-- TOC entry 220 (class 1259 OID 18729)
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3797 (class 0 OID 0)
-- Dependencies: 220
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- TOC entry 221 (class 1259 OID 18730)
-- Name: credit_card; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credit_card (
    id integer NOT NULL,
    cardholder_name character varying(40) NOT NULL,
    expiration_date date NOT NULL,
    cvv integer NOT NULL,
    client_id integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone,
    card_number character varying(50) NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 18733)
-- Name: credit_card_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.credit_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3798 (class 0 OID 0)
-- Dependencies: 222
-- Name: credit_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.credit_card_id_seq OWNED BY public.credit_card.id;


--
-- TOC entry 223 (class 1259 OID 18734)
-- Name: fee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fee (
    id integer NOT NULL,
    amount integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    deleted_date timestamp without time zone,
    fee_type_id integer NOT NULL,
    vehicle_type_id integer NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 18737)
-- Name: fee_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3799 (class 0 OID 0)
-- Dependencies: 224
-- Name: fee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fee_id_seq OWNED BY public.fee.id;


--
-- TOC entry 225 (class 1259 OID 18738)
-- Name: fee_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fee_type (
    id integer NOT NULL,
    description character varying(30) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    deleted_date timestamp without time zone
);


--
-- TOC entry 3800 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN fee_type.description; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.fee_type.description IS 'El tipo de tarifa que es (hora, dia, minuto)';


--
-- TOC entry 226 (class 1259 OID 18741)
-- Name: fee_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fee_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3801 (class 0 OID 0)
-- Dependencies: 226
-- Name: fee_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fee_type_id_seq OWNED BY public.fee_type.id;


--
-- TOC entry 227 (class 1259 OID 18742)
-- Name: loyalty; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.loyalty (
    id integer NOT NULL,
    amount_points integer NOT NULL,
    amount_per_point integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone
);


--
-- TOC entry 3802 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN loyalty.amount_points; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.loyalty.amount_points IS 'La cantidad de dinero que da 1 un punto';


--
-- TOC entry 3803 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN loyalty.amount_per_point; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.loyalty.amount_per_point IS 'El valor de cada punto';


--
-- TOC entry 228 (class 1259 OID 18745)
-- Name: loyalty_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.loyalty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3804 (class 0 OID 0)
-- Dependencies: 228
-- Name: loyalty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.loyalty_id_seq OWNED BY public.loyalty.id;


--
-- TOC entry 229 (class 1259 OID 18746)
-- Name: parking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parking (
    id integer NOT NULL,
    park_name character varying(40) NOT NULL,
    spaces integer NOT NULL,
    street_address character varying(40) NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone,
    admin_id integer NOT NULL,
    city_id integer NOT NULL,
    parking_type_id integer NOT NULL,
    loyalty_id integer,
    latitude character varying,
    longitude character varying
);


--
-- TOC entry 230 (class 1259 OID 18751)
-- Name: parking_fee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parking_fee (
    fee_id integer NOT NULL,
    parking_id integer NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 18754)
-- Name: parking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3805 (class 0 OID 0)
-- Dependencies: 231
-- Name: parking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parking_id_seq OWNED BY public.parking.id;


--
-- TOC entry 232 (class 1259 OID 18755)
-- Name: parking_schedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parking_schedule (
    parking_id integer NOT NULL,
    schedule_id integer NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 18758)
-- Name: parking_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parking_type (
    id integer NOT NULL,
    description character varying(30) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    deleted_date timestamp without time zone
);


--
-- TOC entry 234 (class 1259 OID 18761)
-- Name: parking_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parking_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 234
-- Name: parking_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parking_type_id_seq OWNED BY public.parking_type.id;


--
-- TOC entry 235 (class 1259 OID 18762)
-- Name: payment_method; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_method (
    id integer NOT NULL,
    description character varying(30) NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone
);


--
-- TOC entry 236 (class 1259 OID 18765)
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_method_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 236
-- Name: payment_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_method_id_seq OWNED BY public.payment_method.id;


--
-- TOC entry 237 (class 1259 OID 18766)
-- Name: points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.points (
    id integer NOT NULL,
    amount integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone,
    user_id integer NOT NULL
);


--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN points.amount; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.points.amount IS 'La cantidad de puntos que tiene una persona';


--
-- TOC entry 238 (class 1259 OID 18769)
-- Name: points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3809 (class 0 OID 0)
-- Dependencies: 238
-- Name: points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.points_id_seq OWNED BY public.points.id;


--
-- TOC entry 239 (class 1259 OID 18770)
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role (
    id integer NOT NULL,
    description character varying(30) NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone
);


--
-- TOC entry 240 (class 1259 OID 18773)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3810 (class 0 OID 0)
-- Dependencies: 240
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- TOC entry 241 (class 1259 OID 18774)
-- Name: schedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schedule (
    id integer NOT NULL,
    week_day integer,
    opening_time time without time zone NOT NULL,
    closing_time time without time zone NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone
);


--
-- TOC entry 242 (class 1259 OID 18777)
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3811 (class 0 OID 0)
-- Dependencies: 242
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schedule_id_seq OWNED BY public.schedule.id;


--
-- TOC entry 243 (class 1259 OID 18778)
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    user_name character varying(40) NOT NULL,
    last_name character varying(30) NOT NULL,
    email_address character varying(40) NOT NULL,
    user_password character varying NOT NULL,
    document_type character varying NOT NULL,
    user_document character varying(20) NOT NULL,
    user_token character varying(10),
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone,
    ip_address character varying
);


--
-- TOC entry 244 (class 1259 OID 18783)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3812 (class 0 OID 0)
-- Dependencies: 244
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 245 (class 1259 OID 18784)
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role (
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    created_date timestamp with time zone,
    deleted_date timestamp with time zone
);


--
-- TOC entry 246 (class 1259 OID 18787)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vehicle (
    id integer NOT NULL,
    plate character varying(8),
    created_date timestamp without time zone NOT NULL,
    deleted_date timestamp without time zone,
    vehicle_type_id integer NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 18790)
-- Name: vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3813 (class 0 OID 0)
-- Dependencies: 247
-- Name: vehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vehicle_id_seq OWNED BY public.vehicle.id;


--
-- TOC entry 248 (class 1259 OID 18791)
-- Name: vehicle_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vehicle_type (
    id integer NOT NULL,
    description character varying(30) NOT NULL,
    created_date timestamp with time zone NOT NULL,
    deleted_date timestamp with time zone
);


--
-- TOC entry 249 (class 1259 OID 18794)
-- Name: vehicle_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vehicle_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3814 (class 0 OID 0)
-- Dependencies: 249
-- Name: vehicle_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vehicle_type_id_seq OWNED BY public.vehicle_type.id;


--
-- TOC entry 3550 (class 2604 OID 18795)
-- Name: bill id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill ALTER COLUMN id SET DEFAULT nextval('public.bill_id_seq'::regclass);


--
-- TOC entry 3551 (class 2604 OID 18796)
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- TOC entry 3552 (class 2604 OID 18797)
-- Name: city id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- TOC entry 3553 (class 2604 OID 18798)
-- Name: credit_card id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_card ALTER COLUMN id SET DEFAULT nextval('public.credit_card_id_seq'::regclass);


--
-- TOC entry 3554 (class 2604 OID 18799)
-- Name: fee id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee ALTER COLUMN id SET DEFAULT nextval('public.fee_id_seq'::regclass);


--
-- TOC entry 3555 (class 2604 OID 18800)
-- Name: fee_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee_type ALTER COLUMN id SET DEFAULT nextval('public.fee_type_id_seq'::regclass);


--
-- TOC entry 3556 (class 2604 OID 18801)
-- Name: loyalty id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loyalty ALTER COLUMN id SET DEFAULT nextval('public.loyalty_id_seq'::regclass);


--
-- TOC entry 3557 (class 2604 OID 18802)
-- Name: parking id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking ALTER COLUMN id SET DEFAULT nextval('public.parking_id_seq'::regclass);


--
-- TOC entry 3558 (class 2604 OID 18803)
-- Name: parking_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_type ALTER COLUMN id SET DEFAULT nextval('public.parking_type_id_seq'::regclass);


--
-- TOC entry 3559 (class 2604 OID 18804)
-- Name: payment_method id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method ALTER COLUMN id SET DEFAULT nextval('public.payment_method_id_seq'::regclass);


--
-- TOC entry 3560 (class 2604 OID 18805)
-- Name: points id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.points ALTER COLUMN id SET DEFAULT nextval('public.points_id_seq'::regclass);


--
-- TOC entry 3561 (class 2604 OID 18806)
-- Name: role id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- TOC entry 3562 (class 2604 OID 18807)
-- Name: schedule id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedule ALTER COLUMN id SET DEFAULT nextval('public.schedule_id_seq'::regclass);


--
-- TOC entry 3563 (class 2604 OID 18808)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3564 (class 2604 OID 18809)
-- Name: vehicle id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle ALTER COLUMN id SET DEFAULT nextval('public.vehicle_id_seq'::regclass);


--
-- TOC entry 3565 (class 2604 OID 18810)
-- Name: vehicle_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle_type ALTER COLUMN id SET DEFAULT nextval('public.vehicle_type_id_seq'::regclass);


--
-- TOC entry 3567 (class 2606 OID 18812)
-- Name: bill bill_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill
    ADD CONSTRAINT bill_code UNIQUE (code);


--
-- TOC entry 3569 (class 2606 OID 18814)
-- Name: bill bill_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill
    ADD CONSTRAINT bill_pkey PRIMARY KEY (id);


--
-- TOC entry 3571 (class 2606 OID 18816)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- TOC entry 3573 (class 2606 OID 18818)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 18820)
-- Name: credit_card credit_card_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_pkey PRIMARY KEY (id);


--
-- TOC entry 3581 (class 2606 OID 18822)
-- Name: fee_type description; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee_type
    ADD CONSTRAINT description UNIQUE (description);


--
-- TOC entry 3579 (class 2606 OID 18824)
-- Name: fee fee_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee
    ADD CONSTRAINT fee_pkey PRIMARY KEY (id);


--
-- TOC entry 3583 (class 2606 OID 18826)
-- Name: fee_type fee_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee_type
    ADD CONSTRAINT fee_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3597 (class 2606 OID 18828)
-- Name: parking_type id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_type
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 3585 (class 2606 OID 18830)
-- Name: loyalty loyalty_fkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loyalty
    ADD CONSTRAINT loyalty_fkey PRIMARY KEY (id);


--
-- TOC entry 3575 (class 2606 OID 18832)
-- Name: city name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT name UNIQUE (city_name);


--
-- TOC entry 3593 (class 2606 OID 18834)
-- Name: parking_fee parking_fee_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_fee
    ADD CONSTRAINT parking_fee_pkey PRIMARY KEY (fee_id, parking_id);


--
-- TOC entry 3587 (class 2606 OID 18836)
-- Name: parking parking_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking
    ADD CONSTRAINT parking_name UNIQUE (park_name);


--
-- TOC entry 3589 (class 2606 OID 18838)
-- Name: parking parking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking
    ADD CONSTRAINT parking_pkey PRIMARY KEY (id);


--
-- TOC entry 3595 (class 2606 OID 18840)
-- Name: parking_schedule parking_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_schedule
    ADD CONSTRAINT parking_schedule_pkey PRIMARY KEY (parking_id, schedule_id);


--
-- TOC entry 3599 (class 2606 OID 18842)
-- Name: parking_type parking_type_description; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_type
    ADD CONSTRAINT parking_type_description UNIQUE (description);


--
-- TOC entry 3601 (class 2606 OID 18844)
-- Name: payment_method payment_method_description; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_description UNIQUE (description);


--
-- TOC entry 3603 (class 2606 OID 18846)
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3605 (class 2606 OID 18848)
-- Name: points points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.points
    ADD CONSTRAINT points_pkey PRIMARY KEY (id);


--
-- TOC entry 3607 (class 2606 OID 18850)
-- Name: role role_description; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_description UNIQUE (description);


--
-- TOC entry 3609 (class 2606 OID 18852)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3611 (class 2606 OID 18854)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 3591 (class 2606 OID 18856)
-- Name: parking street_address; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking
    ADD CONSTRAINT street_address UNIQUE (street_address);


--
-- TOC entry 3613 (class 2606 OID 18858)
-- Name: user user_document; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_document UNIQUE (user_document);


--
-- TOC entry 3615 (class 2606 OID 18860)
-- Name: user user_email_address; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_address UNIQUE (email_address);


--
-- TOC entry 3617 (class 2606 OID 18862)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3619 (class 2606 OID 18864)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 3621 (class 2606 OID 18866)
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (id);


--
-- TOC entry 3623 (class 2606 OID 18868)
-- Name: vehicle_type vehicle_type_description; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle_type
    ADD CONSTRAINT vehicle_type_description UNIQUE (description);


--
-- TOC entry 3625 (class 2606 OID 18870)
-- Name: vehicle_type vehicle_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle_type
    ADD CONSTRAINT vehicle_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3626 (class 2606 OID 18871)
-- Name: bill bill_booking_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill
    ADD CONSTRAINT bill_booking_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id) NOT VALID;


--
-- TOC entry 3627 (class 2606 OID 18876)
-- Name: bill bill_payment_method_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill
    ADD CONSTRAINT bill_payment_method_fkey FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(id) NOT VALID;


--
-- TOC entry 3628 (class 2606 OID 18881)
-- Name: booking booking_parking_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_parking_fkey FOREIGN KEY (parking_id) REFERENCES public.parking(id) NOT VALID;


--
-- TOC entry 3629 (class 2606 OID 18886)
-- Name: booking booking_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) NOT VALID;


--
-- TOC entry 3630 (class 2606 OID 18891)
-- Name: booking booking_vehicle_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_vehicle_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(id) NOT VALID;


--
-- TOC entry 3631 (class 2606 OID 18896)
-- Name: credit_card credit_card_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_client_fkey FOREIGN KEY (client_id) REFERENCES public."user"(id);


--
-- TOC entry 3632 (class 2606 OID 18901)
-- Name: fee fee_fee_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee
    ADD CONSTRAINT fee_fee_type_fkey FOREIGN KEY (fee_type_id) REFERENCES public.fee_type(id) NOT VALID;


--
-- TOC entry 3638 (class 2606 OID 18906)
-- Name: parking_fee fee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_fee
    ADD CONSTRAINT fee_id_fkey FOREIGN KEY (fee_id) REFERENCES public.fee(id);


--
-- TOC entry 3633 (class 2606 OID 18911)
-- Name: fee fee_vehicle_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee
    ADD CONSTRAINT fee_vehicle_type_fkey FOREIGN KEY (vehicle_type_id) REFERENCES public.vehicle_type(id) NOT VALID;


--
-- TOC entry 3634 (class 2606 OID 18916)
-- Name: parking parking_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking
    ADD CONSTRAINT parking_admin_fkey FOREIGN KEY (admin_id) REFERENCES public."user"(id) NOT VALID;


--
-- TOC entry 3635 (class 2606 OID 18921)
-- Name: parking parking_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking
    ADD CONSTRAINT parking_city_fkey FOREIGN KEY (city_id) REFERENCES public.city(id) NOT VALID;


--
-- TOC entry 3639 (class 2606 OID 18926)
-- Name: parking_fee parking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_fee
    ADD CONSTRAINT parking_id_fkey FOREIGN KEY (parking_id) REFERENCES public.parking(id);


--
-- TOC entry 3636 (class 2606 OID 18931)
-- Name: parking parking_loyalty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking
    ADD CONSTRAINT parking_loyalty_fkey FOREIGN KEY (loyalty_id) REFERENCES public.loyalty(id) NOT VALID;


--
-- TOC entry 3637 (class 2606 OID 18936)
-- Name: parking parking_parking_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking
    ADD CONSTRAINT parking_parking_type_fkey FOREIGN KEY (parking_type_id) REFERENCES public.parking_type(id) NOT VALID;


--
-- TOC entry 3640 (class 2606 OID 18941)
-- Name: parking_schedule parking_schedule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_schedule
    ADD CONSTRAINT parking_schedule_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedule(id);


--
-- TOC entry 3642 (class 2606 OID 18946)
-- Name: points points_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.points
    ADD CONSTRAINT points_user_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) NOT VALID;


--
-- TOC entry 3643 (class 2606 OID 18951)
-- Name: user_role role_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT role_user_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 3815 (class 0 OID 0)
-- Dependencies: 3643
-- Name: CONSTRAINT role_user_fkey ON user_role; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON CONSTRAINT role_user_fkey ON public.user_role IS 'user_id foreign key';


--
-- TOC entry 3641 (class 2606 OID 18956)
-- Name: parking_schedule schedule_parking_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parking_schedule
    ADD CONSTRAINT schedule_parking_fkey FOREIGN KEY (parking_id) REFERENCES public.parking(id);


--
-- TOC entry 3644 (class 2606 OID 18961)
-- Name: user_role user_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_fkey FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- TOC entry 3816 (class 0 OID 0)
-- Dependencies: 3644
-- Name: CONSTRAINT user_role_fkey ON user_role; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON CONSTRAINT user_role_fkey ON public.user_role IS 'role_id foreign key';


--
-- TOC entry 3645 (class 2606 OID 18966)
-- Name: vehicle vehicle_vehicle_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_vehicle_type_fkey FOREIGN KEY (vehicle_type_id) REFERENCES public.vehicle_type(id) NOT VALID;


-- Completed on 2024-05-30 14:29:14 -05

--
-- PostgreSQL database dump complete
--
