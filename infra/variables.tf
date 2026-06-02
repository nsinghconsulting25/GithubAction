variable "region" {
  default = "us-east-1"
}

variable "ecr_name" {
  default = "mywebapi"
}

variable "cluster_name" {
  default = "mywebapi-cluster"
}

variable "alb_name" {
  default = "mywebapi-alb"
}

variable "tg_name" {
  default = "mywebapi-tg"
}

variable "task_name" {
  default = "mywebapi-task"
}

variable "service_name" {
  default = "mywebapi-service"
}

variable "container_name" {
  default = "mywebapi-container"
}