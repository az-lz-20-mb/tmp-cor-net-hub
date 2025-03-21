variable "index_map" {
  type = map(object({
    rg = string
    location = string
  }))
}
variable "tenant" {
  type = string
}