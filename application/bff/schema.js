export const typeDefs = `#graphgl
type Commission {
    amount: Int
}
type Query {
    clearing(payment_type: String, partner_id: Int, amount: Int): Commission
}
`