-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT *
FROM crime_scene_reports
WHERE year=2023 AND month=7 AND day=28 AND street='Humphrey Street';
-- Needed to know information about crime, like interviews that were about this from witnessers, and an accurate time about when the crime was made

SELECT *
FROM interviews
WHERE year=2023 AND month=7 AND day=28;
-- There i did know about the interviews that were made, and some clues about transactions, thief parking, and the call he made.

SELECT *
FROM bakery_security_logs
WHERE year=2023 AND month=7 AND day=28 AND hour=10 AND minute>=15 AND activity='exit'
ORDER BY minute;
-- From that i wanted to take a knowledge about license keys of them and analyze the given information

SELECT *
FROM people
WHERE license_plate IN (SELECT license_plate
FROM bakery_security_logs
WHERE year=2023 AND month=7 AND day=28 AND hour=10 AND minute>=15 AND activity='exit');
-- I was given some information about the people who had those license plates

SELECT caller
FROM phone_calls
WHERE year = 2023
AND month = 7
AND day = 28
AND duration <= 60
AND (
    caller IN (
        SELECT phone_number
        FROM people
        WHERE license_plate IN (
            SELECT license_plate
            FROM bakery_security_logs
            WHERE year = 2023
            AND month = 7
            AND day = 28
            AND hour = 10
            AND minute >= 15
            AND activity = 'exit'
        )
    )
);
-- I obtained the information about the suspect's phone number


SELECT *
FROM atm_transactions
WHERE year = 2023
AND month = 7
AND day = 28
AND atm_location = 'Leggett Street'
AND transaction_type = 'withdraw';
-- Found information about the people who withdraw the money in the day of crime in Leggett Street according to one of the interviewers.

SELECT receiver,caller
FROM phone_calls
WHERE year=2023 AND month=7 AND day=28 AND duration<=60
AND caller IN(
SELECT phone_number
FROM people
WHERE id IN
    (
    SELECT person_id
    FROM bank_accounts
    WHERE account_number IN
        (
        SELECT account_number
        FROM atm_transactions
        WHERE year = 2023
        AND month = 7
        AND day = 28
        AND atm_location = 'Leggett Street'
        AND transaction_type = 'withdraw'
        )
    )
AND phone_number IN
    (
    SELECT caller
    FROM phone_calls
    WHERE year = 2023
    AND month = 7
    AND day = 28
    AND duration <= 60
    AND caller IN
        (
        SELECT phone_number
        FROM people
        WHERE license_plate IN
            (
            SELECT license_plate
            FROM bakery_security_logs
            WHERE year = 2023
            AND month = 7
            AND day = 28
            AND hour = 10
            AND minute >= 15
            AND activity = 'exit'
            )
        )
    )
AND license_plate IN
    (
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2023
    AND month = 7
    AND day = 28
    AND hour = 10
    AND minute >= 15
    AND minute <= 25
    AND activity = 'exit'
    ));
/* By comparing all the information i have found out about the suspects phone number,license and accound number I have found the 2 suspects
of thief and their accomplice:
suspect thief's number:
(770) 555-1861
(367) 555-5533
suspect accomplice's number:
(375) 555-8161
(725) 555-3243
I needed to check tickets of those numbers.
*/

SELECT *
FROM passengers
WHERE passport_number=3592750733 OR passport_number=5773159633;
-- Found the tickets of those thiefs

SELECT *
FROM flights
WHERE id IN(
    SELECT flight_id
    FROM passengers
    WHERE passport_number=5773159633);
/*
Checked the tickets of those people, it was said by one of the interviewers that the thief planned to buy the ticket with earliest
fly to escape from the city
*/

SELECT *
FROM flights
WHERE id IN(
    SELECT flight_id
    FROM passengers
    WHERE passport_number=3592750733);
/*By comparing the fly of those people, i made a conclusion that diane is innocent, as she have several tickets, and not so early as Bruce's
ticket, after i found his accomplice by launching code above, having receiver and caller.
*/

SELECT city
FROM airports
WHERE id IN (
SELECT destination_airport_id
FROM flights
WHERE id IN(
    SELECT flight_id
    FROM passengers
    WHERE passport_number=5773159633));
--Using this code, i found out to what city thief plan to fly
