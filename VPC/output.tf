output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "public_subs_id" {
  value = [
           element(aws_subnet.public_subs.*.id,0),
           element(aws_subnet.public_subs.*.id,1)
          ]
}

output "private_subs_id" {
  value = [
           element(aws_subnet.private_subs.*.id,0),
           element(aws_subnet.private_subs.*.id,1)
          ]
}

output "private_subs_range" {
  value = [
           element(aws_subnet.private_subs.*.cidr_block,0),
           element(aws_subnet.private_subs.*.cidr_block,1)
          ]
}

output "igw_id" {
  value = aws_internet_gateway.gw.id
}

output "ngw_id" {
  value = aws_nat_gateway.ngw.id
}




