CREATE SEQUENCE event_id_seq START 1;

CREATE OR REPLACE FUNCTION f_auction_payload()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE
    payload_json JSON := NEW.payload::JSON;
    event_id INTEGER;
BEGIN
    event_id := nextval('event_id_seq');
    INSERT INTO auctioneer (event_id, firstname, lastname, nickname, email)
    VALUES (
        event_id,
        payload_json->'auctioneer'->>'firstname',
        payload_json->'auctioneer'->>'lastname',
        payload_json->'auctioneer'->>'nickname',
        payload_json->'auctioneer'->>'email'
    );
    INSERT INTO attachment (event_id, filename, datacenter, localname)
    VALUES (
        event_id,
        payload_json->'attachment'->>'filename',
        payload_json->'attachment'->'location'->>'datacenter',
        payload_json->'attachment'->'location'->>'localname'
    );
    INSERT INTO bet (event_id, volume, ts)
    VALUES (
        event_id,
        (payload_json->'bet'->>'volume')::NUMERIC,
        to_timestamp((payload_json->'bet'->>'ts')::BIGINT)
    );
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_auction_payload
INSTEAD OF INSERT ON v_auction_payload
FOR EACH ROW
EXECUTE FUNCTION f_auction_payload();
