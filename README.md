<div align="center">
  <img src="https://user-images.githubusercontent.com/79160439/156462183-a7ca1d49-4f94-4718-ba17-dc5a8873819d.png" width="200px">
  <p>A coding challenge for the Software Engineer role at Slang</p>
</div>

## Usage
Clone the repository

```bash
$ git clone https://github.com/katsuragawaa/slang-challenge.git
$ cd slang-challenge
```

After that, set your API key as an environment variable:

```bash
$ export SLANG_CHALLENGE_API_KEY='your_api_key'
```

Then run the server:

```bash
$ ruby server.rb
```

## Tests
There are two tests of the services that the server uses to create the final JSON.

To run them:

```bash
$ ruby ./tests/sort_activities_service.rb && ruby ./tests/users_sessions_service_test.rb
```

## Notes

Time Complexity: O(n)

- Up to 10^8 activities, the code runs fine (4ms ~ 100ms)
- Above that amount, it takes about 5 seconds or raises a `NoMemoryError`
- The `convert_timestamp' method takes about 80% of the total time
