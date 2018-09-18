variable "queue_name" {}
output "queue_arn" {
  value = "${aws_sqs_queue.queue.arn}"
}
output "deadletter_queue_arn" {
  value = "${aws_sqs_queue.deadletter_queue.arn}"
}
resource "aws_sqs_queue" "queue" {
  name                      = "${var.queue_name}"
  //  delay_seconds             = 90
  //  max_message_size          = 2048
  //  message_retention_seconds = 86400
  receive_wait_time_seconds = 20
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.deadletter_queue.arn}\",\"maxReceiveCount\":3}"
}


resource "aws_sqs_queue" "deadletter_queue" {
  name                      = "${var.queue_name}_deadletter"
  receive_wait_time_seconds = 20
}
