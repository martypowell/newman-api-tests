REM Run Newman Tests
start newman run "tests/RefusePickup.postman_collection.json" -r json --reporter-json-export "newman/refuse-api-results.json"
exit