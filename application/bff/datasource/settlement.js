import protoLoader from '@grpc/proto-loader'
import grpc from '@grpc/grpc-js'

const ProtoPath = './proto/settlement.proto'
const packageDefinition = protoLoader.loadSync(ProtoPath)
const settlement_proto = grpc.loadPackageDefinition(packageDefinition).settlement

const clientUri = process.env.CATALOGUE_CLIENT_URI || "localhost:50051"
console.log(clientUri)

const client = new settlement_proto.Clearing(
    clientUri, grpc.credentials.createInsecure()
)
        
export class ClearingDataSource {
    constructor(options) {
        this.client = client
    }

    async postClearing(payment_type, partner_id, amount) {
        return new Promise((resolve, reject) => {
            this.client.PostClearing({payment_type: payment_type, partner_id: partner_id, amount: amount}, (error, response) => {
                if (error) {
                    return reject(error)
                } else {
                    return resolve(response.commission);
                }
            });
        });
    }
}