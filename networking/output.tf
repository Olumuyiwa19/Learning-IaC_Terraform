#---- networking/output.tf

output "vpc_id" {
    value = aws_vpc.muykol_vpc.id
    
}
