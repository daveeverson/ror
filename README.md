
## Tribal Contacts Rails

| Lead Developer | Business Contact | Cost Code              |
| -------------- | ---------------- | ---------------------- |
| @jemoua        | Annalee Garletz  |       - Maintenance    |
|                |                  |       - Enhancement    |

DEV: https://webapps15-dev.dnr.state.mn.us/tribal_contacts

PROD: https://webapps15.dnr.state.mn.us/tribal_contacts

# FWIW

The app uses the embedded html editor 'ckeditor' via the 'ckeditor_rails' gem.
This was a PITA to compile into the asset pipeline.

In 'config/environments/production.rb':

```ruby
  config.assets.precompile += ['ckeditor/*']
```

In 'app/assets/javascripts/ckeditor/' create the file: basepath.rb and add the following line:
```ruby
var CKEDITOR_BASEPATH = '/tribal_contacts/assets/ckeditor/';
```

At the command line:
```sh
RAILS_ENV=production bundle exec rake assets:precompile RAILS_RELATIVE_ROOT=/tribal_contacts
```

This will precompile assets into public/ with the proper rails relative root.