# output "instance_publicip" {
#   description = "ECT instance public ip"
#   value       = aws_instance.myec2vm.public_ip
# }

# output "instance_publicdns" {
#   description = "ECT instance public dns"
#   value       = aws_instance.myec2vm.public_dns
# }

output "for_output_list" {
  description = "For loop with list"
  value = [for instance in aws_instance.myec2vm: instance.public_dns]
}

output "for_output_map1" {
  description = "For loop with map"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}

output "for_output_map2" {
  description = "For loop with map - advanced"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}

output "legacy_splat_instance_publicdns" {
  description = "legacy splat operator"
  value = aws_instance.myec2vm.*.public_dns
}

output "latest_splat_instance_publicdns" {
  description = "latest splat operator"
  value = aws_instance.myec2vm[*].public_dns
}