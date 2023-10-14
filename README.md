# falcon-fedx-ruby-template

A basic Ruby on Rails app that can be used to start a new Falcon service.

## Use this FedX template to spin up your service

Run this command from your local workstation:

```
$ falcon init --template https://git.soma.salesforce.com/Falcon-Adoption-Engineering/falcon-fedx-ruby-template
```

This will prompt you for the location of your new repository, populate it with the code from this template, and initialize it for Falcon.

## Working with the application

### HTTP Endpoints

#### `/`

This endpoint renders a `text/plain` response and is useful for determining if the service is running

```
$ curl 0.0.0.0:8080
=>
```

```
Hello, World!
```

### HTTP Endpoints with S3 behavior

#### Enviroment variables

The following environment variables need to be set for intergration with S3

```
- ACCOUNT_ID
- SERVICE_NAME
- INSTANCE_ID
- AWS_REGION
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_SESSION_TOKEN
```

#### `/upload`

Uploads a file to a Falcon S3 Addon bucket

```
$ curl -F data=@metrics.txt 0.0.0.0:8080/upload
=>
```

```
{
  "etag": "\"ad606d6a24a2dec982bc2993aaaf9160\"",
  "server_side_encryption": "AES256",
  "version_id": "545doNV8i5O5tewqHkHFdGUEFaoKr3H_"
}
```

#### `/list`

```
$ curl 0.0.0.0:8080/list
=>
```

```html
<!DOCTYPE html>
<html>
<head>
  <title>Falcon Codelabs Object Storage</title>
</head>
<body>
  <h1>Bucket Objects</h1>
<p><i>maximum of 5 objects shown</i></p>

<ul>
  <li>cat.txt
  <li>cookie
  <li>gigawatts.jpeg
  <li>logs.txt
  <li>metrics.txt
</ul>

</body>
</html>
```

```
$ curl -H "Accept: application/json" 0.0.0.0:8080/list | jq '.[0]'
=>
```

```
{
  "key": "cat.txt",
  "last_modified": "2023-03-09T18:43:55.000Z",
  "etag": "\"ad606d6a24a2dec982bc2993aaaf9160\"",
  "checksum_algorithm": [],
  "size": 5,
  "storage_class": "STANDARD",
  "owner": {
    "display_name": "pcsk-aws+dzd2sXL1l28mj2LKSZ78Iobwp6xMUNhMpABute",
    "id": "631505e23ef61a5884cbd620ccd2e2bdce0b1cc3933db837eb70f745eb756973"
  }
}
```

### Rails console

```
[root@e9f3062171d2 app]# ./bin/rails c
Loading development environment (Rails 7.0.4.2)
```

```ruby
irb(main):001:0> FalconCodelabs::Aws::S3.new.list_objects.take(1)
=>
```

```
[#<struct Aws::S3::Types::Object
  key="cat.txt",
  last_modified=2023-03-09 18:43:55 UTC,
  etag="\"ad606d6a24a2dec982bc2993aaaf9160\"",
  checksum_algorithm=[],
  size=5,
  storage_class="STANDARD",
  owner=#<struct Aws::S3::Types::Owner display_name="pcsk-aws+dzd2sXL1l28mj2LKSZ78Iobwp6xMUNhMpABute", id="631505e23ef61a5884cbd620ccd2e2bdce0b1cc3933db837eb70f745eb756973">>]
```

### Exception handling

The application attempts to gracefully handle AWS Configuration exceptions

```
$ curl 0.0.0.0:8080/list
=>
```

```
#<FalconCodelabs::Errors::AwsConfiguration: No region was provided. Configure the `:region` option or export the region name to ENV['AWS_REGION']>
```
