# README

## Task description
Task description can be found in [REQUIREMENTS.md](https://github.com/vlaew/task_samples/blob/master/posts_app_api/doc/REQUIREMENTS.md)

The key point of this task is to design and implement an API for a hypothetical mobile app. Key endpoints for list of 
posts/comments and ability to like a post are implemented here and covered with request tests, while out of the scope things like users authentication 
endpoint is more like a mock up.

### [Demo App](https://sample-posts.herokuapp.com/)

### API Design

To fullfill the performance requirement API is designed with the following
in mind:

 - Data common for all users and data specific for a certain user should be served by
 separate endpoints. That way responses payload can be cached inside the app and in users' browser.
 In this app we have posts feed which is common for all users and served by `/posts` endpoint and 
 list of liked posts specific for each individual user which is served by `/my_likes` endpoint.   
 - Posts feed is served paginated accepting page number parameter. Posts endpoint doesn't accept per_page parameter.
 Also we use relatively large number of posts per page which should lead to smaller number of requests to the endpoint.
 

### Implementation approaches

A set of different tools and approaches is tested in this app. 
For json payload rendering used:
 - `jbuilder` template ([controller](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/controllers/api/jbuilder/posts_controller.rb), [view](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/views/api/jbuilder/posts/index.json.jbuilder))
 - `fast_jsonapi` backed serializer ([controller](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/controllers/api/fast_jsonapi_serializer/posts_controller.rb), [serializer](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/serializers/post_serializer.rb))
 - self implemented serializer ([controller](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/controllers/api/simple_serializer/posts_controller.rb), [serializer](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/carriers/post_carrier.rb))
 
Used caching techniques:
 - `jbuilder` template fragment caching ([controller](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/controllers/api/jbuilder_fragment_cache/posts_controller.rb), [view](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/views/api/jbuilder_fragment_cache/posts/index.json.jbuilder))
 - `fast_jsonapi` serializer caching ([serializer](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/serializers/post_serializer.rb))
 - `Rails.cache` for caching serialized json response payload ([controller](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/controllers/api/fast_jsonapi_serializer_cached/posts_controller.rb))
 - Client side caching with Rails conditional GET ([controller](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/controllers/api/fast_jsonapi_serializer_cached_http_cache/posts_controller.rb))
 
Key implementation details can be found in:
 - `PostsController`s in [dedicated namespaces](https://github.com/vlaew/task_samples/tree/master/posts_app_api/app/controllers/api) for different approaches;
 - [PostsCarrier](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/carriers/posts_carrier.rb) & [PostCarrier](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/carriers/post_carrier.rb) - posts page retrieving and serialization logic;
 - [PostSerializer](https://github.com/vlaew/task_samples/blob/master/posts_app_api/app/serializers/post_serializer.rb) - `fast_jsonapi` backed serializer; 

### Implementations benchmarking

Tested with `ab` tool. Fetching posts feed page with 500 entries.

    ab -c 1 -n 1000 http://localhost:3000/api/jbuilder/posts 

| Implementation | Requests per second | Time per request |
|----------------|---------------------|------------------|
| jbuilder | 17.95 | 55.706 ms |
| jbuilder fragment cache | 9.94 | 100.591 ms |
| simple serializer | 20.50 | 48.772 ms |
| simple serializer with caching | 30.82 | 32.447 ms |
| fast_jsonapi | 14.39 | 69.488 ms |
| fast_jsonapi with caching | 31.44 | 31.803 ms |
| http cached | 155.34 | 6.438 ms |

## Requirements

 * Ruby 2.6.5

## Setup

 * Install dependencies: `bundle install`
 * Setup local dev DB: `bin/rails db:setup`
 * Run the tests: `bin/rspec`
 * Start the app: `bin/rails s`
 
## API Endpoints

#### Sign in

Path: `/api/v1/sessions`

Method: `POST`

Requires authentication: `no`

Submit body schema: 
```json
{
  "type": "object",
  "required": ["email"],
  "properties": {
    "email": { "type": "string" }
  }
}
```

Response schema (on successful authentication):
```json
{
  "type": "object",
  "required": ["token"],
  "properties": {
    "token": { "type": "string" }
  }
}
```

Curl example (successful):
```bash
curl -d '{"email":"user@example.com"}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/sessions

Response:
HTTP/1.1 200 OK
{"token":"oq5WWSZLCwN2u_-H"}
```

Curl example (unsuccessful):
```bash
curl -d '{"email":"non_existent@example.com"}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/sessions

Response:
HTTP/1.1 401 Unauthorized
{"message":"You need to be authenticated for this"}
```

#### Posts list

Paths: 
 - `/api/v1/posts`
 - `/api/jbuilder/posts`
 - `/api/jbuilder_fragment_cache/posts`
 - `/api/simple_serializer/posts`
 - `/api/simple_serializer_cached/posts`
 - `/api/fast_jsonapi_serializer/posts`
 - `/api/fast_jsonapi_serializer_cached/posts`
 - `/api/fast_jsonapi_serializer_cached_http_cache/posts`

Method: `GET`

Requires authentication: `no`

Arguments:
 * `page` - (integer) page number to return from the collection

Response schema:
```json
{
  "type": "object",
  "required": ["data", "meta"],
  "properties": {
    "data": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "type", "attributes"],
        "properties": {
          "id": { "type": "string" },
          "type": { "type": "string" },
          "relationships": { "type": "object" },
          "attributes": {
            "type": "object",
            "required": ["body", "likes_count", "published_at"],
            "properties": {
              "body": { "type": "string" },
              "likes_count": { "type": "integer" },
              "published_at": { "type": "date-time" }
            }
          }
        }
      }
    },
    "meta": {
      "type": "object",
      "required": ["total_count"],
      "properties": {
        "total_count": { "type": "integer" }
      }
    }
  }
}
```

Curl example:
```bash
curl -H "Content-Type: application/json" http://localhost:3000/api/v1/posts?page=2
```
```json
{
  "data": [
    {
      "id": "500",
      "type": "post",
      "attributes": {
        "id": 500,
        "body": "Ipsum suspendisse ultrices gravida dictum fusce ut placerat orci. Lorem ipsum dolor sit amet consectetur adipiscing elit.",
        "likes_count": 22,
        "published_at": "2020-04-26T20:48:40.901Z"
      },
      "relationships": {}
    },
    {
      "id": "499",
      "type": "post",
      "attributes": {
        "id": 499,
        "body": "Sed faucibus turpis in eu mi bibendum neque egestas. Augue ut lectus arcu bibendum at varius vel.",
        "likes_count": 23,
        "published_at": "2020-04-26T20:48:40.897Z"
      },
      "relationships": {}
    }
  ],
  "meta": {
    "total_count": 1000
  }
}
```

#### Post toggle like

Path: `/api/v1/posts/$post_id/toggle_like`

Method: `POST`

Requires authentication: `yes`

Arguments: `none`

Response: `HTTP/1.1 200 OK`

Curl example:
```bash
curl -H "Authorization: Token tDDozs_X6mUK-p3k" -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/posts/900/toggle_like
```

#### Current user likes

Path: `/api/v1/my_likes`

Method: `GET`

Requires authentication: `yes`

Arguments:
 * `page` - (integer) page number same as for posts

Response schema:
```json
{
  "type": "object",
  "required": ["liked_posts"],
  "properties": {
    "liked_posts": {
      "type": "array",
      "items": { "type": "integer" }
    }
  }
}
```

Curl example:
```bash
curl -H "Authorization: Token tDDozs_X6mUK-p3k" -H "Content-Type: application/json" http://localhost:3000/api/v1/my_likes
```
```json
{
  "liked_posts": [503,505,507,510,512,515,521,524,528,529,530]
}
```

#### Post comments

Path: `/api/v1/posts/$post_id/comments`

Method: `GET`

Requires authentication: `no`

Arguments:
 * `page` - (integer) page number to return from the collection
 * `per_page` - (integer) number of comments per page (upto 100)

Response schema:
```json
{
  "type": "object",
  "required": ["collection"],
  "properties": {
    "collection": {
      "type": "object",
      "required": ["data", "total_pages", "current_page"],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["id", "body", "created_at", "created_by"],
            "properties": {
              "id": { "type": "integer" },
              "body": { "type": "string" },
              "created_at": { "type": "date-time" },
              "created_by": {
                "type": "object",
                "required": ["id", "name"],
                "properties": {
                  "id": { "type": "integer" },
                  "name": { "type": "string" }
                }
              }
            }
          }
        },
        "total_pages": { "type": "integer" },
        "current_page": { "type": "integer" }
      }
    }
  }
}
```

Curl example:
```bash
curl -H "Content-Type: application/json" http://localhost:3000/api/v1/posts/19/comments
```
```json
{
  "collection": {
    "data": [
      {
        "id": 163,
        "body": "Comment #163",
        "created_at": "2020-04-07T20:45:51.529Z",
        "created_by": {
          "id": 1,
          "name": "John Doe"
        }
      },
      {
        "id": 164,
        "body": "Comment #164",
        "created_at": "2020-04-07T20:45:51.548Z",
        "created_by": {
          "id": 2,
          "name": "Jane Smith"
        }
      },
      {
        "id": 165,
        "body": "Comment #165",
        "created_at": "2020-04-07T20:45:51.569Z",
        "created_by": {
          "id": 3,
          "name": "Alice Jones"
        }
      },
      {
        "id": 166,
        "body": "Comment #166",
        "created_at": "2020-04-07T20:45:51.589Z",
        "created_by": {
          "id": 4,
          "name": "Victor Grenkin"
        }
      },
      {
        "id": 167,
        "body": "Comment #167",
        "created_at": "2020-04-07T20:45:51.608Z",
        "created_by": {
          "id": 5,
          "name": "Sara Jenkins"
        }
      },
      {
        "id": 168,
        "body": "Comment #168",
        "created_at": "2020-04-07T20:45:51.625Z",
        "created_by": {
          "id": 1,
          "name": "John Doe"
        }
      },
      {
        "id": 169,
        "body": "Comment #169",
        "created_at": "2020-04-07T20:45:51.643Z",
        "created_by": {
          "id": 2,
          "name": "Jane Smith"
        }
      },
      {
        "id": 170,
        "body": "Comment #170",
        "created_at": "2020-04-07T20:45:51.662Z",
        "created_by": {
          "id": 3,
          "name": "Alice Jones"
        }
      },
      {
        "id": 171,
        "body": "Comment #171",
        "created_at": "2020-04-07T20:45:51.684Z",
        "created_by": {
          "id": 4,
          "name": "Victor Grenkin"
        }
      }
    ],
    "total_pages": 1,
    "current_page": 1
  }
}
```
