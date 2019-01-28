resource "aws_route53_zone" "worpress53" {
  name = "wordpressite.com"
}
# resource "aws_route53_record" "www" {
#   zone_id = "${aws_route53_zone.primary.zone_id}"
#   name    = "veryeasycloud.com"
#   type    = "A"
#   ttl     = "300"
#   records = ["${aws_eip.lb.public_ip}"]

#   alias {
#     name                   = "${aws_lb.test.dns_name}"
#     zone_id                = "${aws_lb.test.zone_id}"
#     evaluate_target_health = true
#   }
# }

resource "aws_route53_record" "wordpress" {
zone_id = "${aws_route53_zone.worpress53.zone_id}"
name    = "veryeasycloud.com"
type = "CNAME"
ttl = "60"
records = ["${aws_lb.wp_lb.dns_name}"]

}