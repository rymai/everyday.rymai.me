## everyday.rymai.me

This app allows you to display your "Everyday" photos (from the iOS app) in a (cool) website.

### How it works

1. The `move_public_everyday_photos_into_set` rake task moves all public photos taken (and uploaded)
  by the Everyday app to the "Everyday" set on Flickr. It also changes their permissions so that only
  you can see them on Flickr. Last but not least, it backup the photos to an S3 bucket. I advise you to
  schedule this task every day.

2. When someone visits the site, the app retrieves the pictures from the "Everyday" set on Flickr and display
  the current week's photos, last week's photos and 7 random photos.

3. The `download_everyday_set_photos` rake task can be run locally to download all you "Everyday" photos to
  your computer (if you'd like to make a video with them for instance).

### Setup

#### 1. Setup S3 credentials.

The possible keys can be found in `config/s3.example.yml`. You can use environment variables to define
S3 credentials and configuration (variables names are upcased keys from `config/s3.example.yml` upcased (e.g. `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` env variables). An alternative solution is to
`cp config/s3.example.yml config/s3.yml` and update its content.
Note that environment variables have precedence over the data from `config/s3.yml`.

#### 2. Setup Flickr credentials.

`cp config/flickr.example.yml config/flickr.yml` and update its content.

#### 3. Setup the app secret token

Set the `SECRET_TOKEN` environment variable.
