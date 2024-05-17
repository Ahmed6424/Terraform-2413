# build LMS Frontend image
resource "docker_image" "lms-fe" {
  name = "ahmedssj6424/lms-fe"
  build {
    context = "."
    tag     = ["ahmedssj6424/lms-fe:latest"]
    label = {
      author : "Ahmed"
    }
  }
}

# start LMS frontend container
resource "docker_container" "lms-fe-container" {
   image = docker_image.lms-fe.image_id
   name  = "lms-frontend"
   ports {
     internal = 80
     external = 80
     ip       = "0.0.0.0"
    }
}
