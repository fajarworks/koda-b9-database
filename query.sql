-- LOGN
SELECT id, fullname, email, photo_profile
FROM users
WHERE email = 'budi@eventhub.com' AND password = 'password123';

-- REGISTER
INSERT INTO users(fullname,email, password, role)
VALUES('maruf', 'maruf@example.com','maruf123', 'organizer');

-- Query search and filter
-- Most Popular
SELECT e.id, e.title, e.image, e.capacity ,e.location , e.date, e.start_time, e.end_time, c.name AS category, count(ue.user_id) AS most_popular
FROM events e
LEFT JOIN user_event ue ON e.id = ue.event_id
JOIN users u ON ue.user_id = u.id
JOIN event_category ec ON e.id = ec.event_id
JOIN categories c ON ec.category_id = c.id
WHERE lower(e.title) LIKE lower('%react%')
AND c.name = 'Web Development'
AND e.location = 'Bandung'
GROUP BY e.id, c.name
ORDER BY most_popular DESC;

-- Upcoming
SELECT e.id, e.title, e.image, e.capacity ,e.location , e.date, e.start_time, e.end_time, c.name AS category
FROM events e
LEFT JOIN user_event ue ON e.id = ue.event_id
JOIN users u ON ue.user_id = u.id
JOIN event_category ec ON e.id = ec.event_id
JOIN categories c ON ec.category_id = c.id
WHERE lower(e.title) LIKE lower('%react%') 
AND c.name = 'Web Development'
AND e.location = 'Bandung'
AND e.date > now()
ORDER BY e.date DESC;

-- Almost full

SELECT e.id, e.title, e.image, e.capacity ,e.location , e.date, e.start_time, e.end_time, c.name AS category, e.capacity - count(DISTINCT ue.user_id) AS almost_full
FROM events e
LEFT JOIN user_event ue ON e.id = ue.event_id
JOIN users u ON ue.user_id = u.id
JOIN event_category ec ON e.id = ec.event_id
JOIN categories c ON ec.category_id = c.id
WHERE lower(e.title) LIKE lower('%react%')
AND c.name = 'Web Development'
-- AND e.location = 'Jakarta'
GROUP BY e.id, c.name
ORDER BY almost_full ASC;

-- Get Detail Event

SELECT
    e.id,
    e.title,
    e.description,
    e.image,
    e.location,
    e.capacity,
    e.date,
    e.start_time,
    e.end_time,

    u.id AS organizer_id,
    u.fullname AS organizer_name,
    u.photo_profile AS organizer_photo, 
    STRING_AGG(DISTINCT c.name) AS categories
FROM events e JOIN users u ON e.organizer_id = u.id
LEFT JOIN event_category ec ON e.id = ec.event_id
LEFT JOIN categories c ON ec.category_id = c.id
WHERE e.id = 1
GROUP BY e.id, u.id;

-- JOIN EVENT 
INSERT INTO user_event (user_id, event_id)
VALUES(1,2);

-- LEAVE EVENT 
DELETE FROM user_event
WHERE user_id = 1 AND event_id = 2;

-- Get Upcoming Event
SELECT id, title,image,location, capacity
FROM events
WHERE date > now()
ORDER BY date ASC;

-- GET My Events

SELECT events.id, events.title, events.location, events.image, events.date, events.start_time, events.end_time
FROM user_event
JOIN events ON user_event.event_id = events.id
WHERE user_event.user_id = 7;

-- GET community list search & filter
SELECT
    c.id,
    c.name,
    c.image,
    c.description
FROM communities c
JOIN community_category cc ON c.id = cc.community_id
JOIN categories cat ON cc.category_id = cat.id
WHERE cat.name = 'Web Development';

-- Comunity Detail

SELECT
    c.id,
    c.name,
    c.image,
    c.description,
    ARRAY_AGG(DISTINCT cat.name) AS categories,
    COUNT(DISTINCT uc.user_id) AS total_members
FROM communities c
JOIN community_category cc
    ON c.id = cc.community_id
JOIN categories cat
    ON cc.category_id = cat.id
JOIN user_community uc
    ON c.id = uc.community_id
WHERE c.id = 1
GROUP BY
    c.id;

-- Join Community

INSERT INTO user_community (user_id, community_id)
VALUES(10, 5);

-- Leave Community
DELETE FROM user_community 
WHERE user_id = 10 AND community_id = 5;

-- GET Popular communities
SELECT communities.id, communities.name, communities.image, COUNT(user_community.user_id) AS popular
FROM communities
LEFT JOIN user_community ON communities.id = user_community.user_id
GROUP BY communities.id
ORDER BY popular DESC;

-- GET Community Members
SELECT users.id, users.fullname, users.photo_profile
FROM user_community
JOIN users ON user_community.user_id = users.id
WHERE user_community.community_id = 1;



-- GET user profile

SELECT fullname, email, location, role, bio 
FROM users
WHERE id = 1;

-- Change user Profile
UPDATE users
SET fullname = 'john wick',
    photo_profile = 'jhon.jpeg',
    location = 'New York',
    bio = 'fortis fortuna adiuvat',
    updated_at = now()
WHERE id = 2;

-- change password
UPDATE users
SET password = 'jhon1234',
    updated_at = now()
WHERE id = 1;

-- Organizer dashboard

SELECT

    (
        SELECT COUNT(*)
        FROM events
        WHERE organizer_id = 3
    ) AS total_event_created,

    (
        SELECT COUNT(DISTINCT ue.user_id)
        FROM user_event ue
        JOIN events e
            ON ue.event_id = e.id
        WHERE e.organizer_id = 3
    ) AS total_attendee_join;

-- CREATE EVENT

INSERT INTO events (
    title,
    description,
    image,
    location,
    capacity,
    created_at,
    date,
    start_time,
    end_time,
    organizer_id
)
VALUES (
    'Building Modern Web Apps with React & Go',
    'Workshop hands-on untuk mempelajari cara membangun aplikasi web modern menggunakan React sebagai frontend dan Go sebagai backend. Peserta akan belajar membuat REST API, menghubungkan frontend dengan backend, serta melakukan deployment menggunakan Docker.',
    '/uploads/events/react-go-workshop.jpg',
    'Jakarta',
    100,
    NOW(),
    '2026-12-20',
    '09:00',
    '13:00',
    2
);
table speakers;
INSERT INTO speakers (
    name,
    role
)
VALUES('Budi Santoso', 'Fullstack engineer');

-- EDIT EVENT

UPDATE events
    SET title = 'Fundamental Go Workshop',
        description = 'learning fundamental Go language from zero',
        location = 'Bogor',
        capacity = 50,
        date = '2026-10-20',
        start_time = '13:00',
        end_time = '15:00'
WHERE id = 7;


-- GET testimony
SELECT testimonials.id, users.fullname, users.photo_profile, testimonials.message 
FROM testimonials
JOIN users ON testimonials.user_id = users.id;

-- SET testimony
INSERT into testimonials (user_id, message)
VALUES (4, 'eventhub sangat membantu saya dalam mengembangkan skill saya di bidang teknologia');


-- Get my notification
SELECT
    type,
    title,
    message,
    is_read
FROM notification
WHERE user_id = 7;

-- Admin Dashboard

SELECT(
    SELECT COUNT(*)
    FROM users
) AS total_users,
(
    SELECT COUNT(*)
    FROM events
)AS total_events,
(
    SELECT COUNT(*)
    FROM communities
)AS total_communities;


