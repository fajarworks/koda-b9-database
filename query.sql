-- LOGN
SELECT id, fullname, email, password
FROM users
WHERE email = 'budi@eventhub.com' AND password = 'password123';

-- REGISTER
INSERT INTO users(fullname,email, password)
VALUES('carlos nainggolan', 'carlosantos@example.com','crlsnggln123');

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

-- Join Community

INSERT INTO user_community (user_id, community_id)
VALUES(10, 5);

-- Leave Community
DELETE FROM user_community 
WHERE user_id = 10 AND community_id = 5;

-- GET Popular communities
SELECT communities.id, communities.name, communities.image, COUNT(user_community.user_id) AS total_members
FROM communities
LEFT JOIN user_community ON communities.id = user_community.user_id
GROUP BY communities.id
ORDER BY total_members DESC;

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
VALUES('Budi Santoso', 'Fullstack engineer')

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
JOIN users ON testimonials.user_id = users.id

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


