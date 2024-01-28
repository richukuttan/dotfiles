!#/bin/bash

source ~/.resticenv
restic -r s3:s3.us-west-004.backblazeb2.com/ResticHrishi --verbose backup ~/Desktop/Notes ~/Documents
restic -r s3:s3.us-west-004.backblazeb2.com/ResticHrishi forget --keep-within 7d --keep-daily 15 --keep-weekly 8 --keep-monthly 24 --keep-yearly 20
restic -r s3:s3.us-west-004.backblazeb2.com/ResticHrishi prune --max-unused 10%

