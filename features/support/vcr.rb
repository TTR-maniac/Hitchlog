VCR.configure do |c|
  c.cassette_library_dir = 'features/support/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
end

VCR.cucumber_tags do |t|
  t.tags  '@hitchhikers',
          '@trips'
end
