# API Documentation for Send Messages

## Introduction

The Send Messages API allows you to send SMS messages using two different providers. It employs a weighted approach to determine which provider to use for sending each message, offering redundancy in case one provider is down. Additionally, the API provides endpoints to check the status of a sent message and retrieve message details.

## Base URL

The base URL for the API is `https://your-api-domain.com/dev`.

### Authentication

This API does not require authentication for message sending and status retrieval.

## Endpoints

### 1. Send Message - Provider One

**Endpoint:** `POST /provider_one`

**Description:** Sends an SMS message using Provider One.

**Request Parameters:**

| Parameter   | Type   | Description                          |
| ----------- | ------ | ------------------------------------ |
| `to_number` | bigint | The recipient's phone number.        |
| `message`   | string | The message content to be sent.      |

**Response:**

If successful, the API returns a JSON response with the following fields:

| Field         | Type   | Description                              |
| ------------- | ------ | ---------------------------------------- |
| `code`        | number | HTTP status code (200 if successful).    |
| `message_id`  | string | The ID of the sent message.             |

If the operation fails, the response will contain an appropriate error message.

### 2. Find Message Status

**Endpoint:** `GET /find_message_status`

**Description:** Retrieves the status of a previously sent message.

**Request Parameters:**

| Parameter    | Type   | Description                                 |
| ------------ | ------ | ------------------------------------------- |
| `message_id` | string | The ID of the message to retrieve status for. |

**Response:**

The API returns a JSON response with the following fields:

| Field         | Type   | Description                                       |
| ------------- | ------ | ------------------------------------------------- |
| `status`      | string | The status of the message (`"invalid"`, `"failed"`, or `"delivered"`). |
| `message_id`  | string | The ID of the requested message.                 |

### 3. Find Message Details

**Endpoint:** `GET /find_message`

**Description:** Retrieves detailed information about a previously sent message.

**Request Parameters:**

| Parameter    | Type   | Description                                 |
| ------------ | ------ | ------------------------------------------- |
| `message_id` | string | The ID of the message to retrieve details for. |

**Response:**

The API returns a JSON response with the following fields:

| Field         | Type   | Description                                       |
| ------------- | ------ | ------------------------------------------------- |
| `id`          | number | The unique ID of the message in the database.    |
| `to_number`   | bigint | The recipient's phone number.                    |
| `message`     | string | The content of the sent message.                 |
| `attempt_status` | string | The status of the message (`"invalid"`, `"failed"`, or `"delivered"`). |
| `message_id`  | string | The ID of the requested message.                 |
| `uuid`        | string | The universally unique identifier for the message. |

### 4. Delivery Status Webhook

**Endpoint:** `POST /delivery_status`

**Description:** Receives delivery status updates from the SMS providers.

**Request Parameters:**

The delivery status webhook receives the following parameters in the request body:

| Parameter    | Type   | Description                                 |
| ------------ | ------ | ------------------------------------------- |
| `message_id` | string | The ID of the message for which the status update is received. |
| `status`     | string | The status of the message (`"invalid"`, `"failed"`, or `"delivered"`). |

**Response:**

The API responds with an HTTP status code of 200 (OK) if the request is successfully processed.

## Error Handling

In case of errors, the API will return an appropriate HTTP status code along with a JSON response containing an error message.

| HTTP Status Code | Error Message                    |
| ---------------- | -------------------------------- |
| 400              | Bad Request - Invalid parameters |
| 404              | Not Found - Message not found    |
| 500              | Internal Server Error            |

## Rate Limiting

The API does not impose any rate limiting for message sending or status retrieval. However, it is advised to implement rate limiting on the client-side to avoid misuse.

## Response Format

Responses from the API will be in JSON format.

## Error Codes

| Error Code | Description                              |
| ---------- | ---------------------------------------- |
| 200        | Success                                  |
| 400        | Bad Request - Invalid parameters         |
| 404        | Not Found - Message not found            |
| 500        | Internal Server Error                    |

## Example Usage

**1. Sending a Message (Provider One)**

**Request:**

```http
POST /dev/send_messages/provider_one
Content-Type: application/json

{
  "to_number": 1234567890,
  "message": "Hello, this is a test message!"
}
```

**Response:**

```json
{
  "code": 200,
  "message_id": "abc123def456"
}
```

**2. Retrieving Message Status**

**Request:**

```http
POST /dev/check_attempt_status
Content-Type: application/json
{
  "message_id": "abc123def456"
}
```

**Response:**

```json
{
  "status": "delivered",
  "message_id": "abc123def456"
}
```

**3. Retrieving Message Details**

**Request:**

```http
POST /dev/find_message
Content-Type: application/json
{
  "message_id": "abc123def456"
}
```

**Response:**

```json
{
  "id": 1,
  "to_number": 1234567890,
  "message": "Hello, this is a test message!",
  "attempt_status": "delivered",
  "message_id": "abc123def456",
  "uuid": "xyz987pqr654"
}
```

## Conclusion

The Send Messages API provides a convenient way to send SMS messages through two different providers, ensuring redundancy and reliability. Additionally, you can retrieve the status and details of sent messages, making it a comprehensive solution for managing SMS communication in your application.