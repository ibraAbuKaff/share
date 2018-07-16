# share
Share your files or text data right away from your terminal and get a shareable link with expiration date.  The link is downloadable only once , then it will be deleted 
 
 This service is using http://file.io
 
 Usage :
 
 `sh share.sh [-f 'PATH_TO_FILE']  [-d 'TEXT_DATA']  '3d|14w|1m|2y'`
 
1- Example -- Upload and share file:
 
 `sh share.sh -f "./dir1/xyz.json" "10d"`  # Expiration date after 10 days <br/>
 `sh share.sh -f "./dir1/xyz.json" "10m"`  # Expiration date after 10 months <br/>
 `sh share.sh -f "./dir1/xyz.json" "10w"`  # Expiration date after 10 weeks <br/>
 `sh share.sh -f "./dir1/xyz.json" "10y"`  # Expiration date after 1 year <br/>
 
 
 2- Example --  Share text data:
 
 `sh share.sh -d "Hello, some shareable text data is here" "10d"`  # Expiration date after 10 days <br/>
 `sh share.sh -d "Hello, some shareable text data is here" "10m"`  # Expiration date after 10 months <br/>
 `sh share.sh -d "Hello, some shareable text data is here" "10w"`  # Expiration date after 10 weeks <br/>
 `sh share.sh -d "Hello, some shareable text data is here" "10y"`  # Expiration date after 1 year <br/>
