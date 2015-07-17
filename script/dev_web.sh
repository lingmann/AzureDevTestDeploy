###########################################
# Build and run the web application.
#
# If docker-machine is present assume that
# docker-machine is managing the docker
# hosts and us that. Otherwise use the same
# machine that this script is running on.
###########################################

eval "$(docker-machine env $DEV_MACHINE_NAME)"
docker-machine env $DEV_MACHINE_NAME

cd asp

# Build the container to ensure we pick up any changes
docker build -t web:latest .

# Stop, remove and restart the container
echo "Stopping any running dev container for web app"
docker stop dev_web
echo "Removing any previous dev container web app"
docker rm dev_web
echo "Running a web app dev container"
docker run -td -p 8888:80 --link dev_rest:rest --name=dev_web web:latest

cd ..