!dpkg --configure -a
!sudo apt-get update
!sudo apt-get install -y ca-certificates curl gnupg
!sudo mkdir -p /etc/apt/keyrings
!curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
!NODE_MAJOR=18 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
!sudo apt-get update
# RUN the following commented lines to remove the previous installed nodejs (avoid conflict error)
!sudo dpkg --remove --force-remove-reinstreq nodejs
!sudo dpkg --remove --force-remove-reinstreq libnode-dev
!sudo dpkg --remove --force-remove-reinstreq libnode72:amd64
!sudo apt-get install nodejs -y