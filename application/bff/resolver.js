export const resolvers = {
    Query: {
        clearing: async (parent, args, context) => {
            const response = await context.dataSources.clearingApi.postClearing(args.payment_type, args.partner_id, args.amount)
            return response
        }
    }
}
