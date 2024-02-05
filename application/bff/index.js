import { ApolloServer } from '@apollo/server';
import { expressMiddleware } from '@apollo/server/express4';
import express from 'express';
import http from 'http';
import cors from 'cors';
import bodyParser from 'body-parser';
import { typeDefs } from './schema.js'
import { resolvers } from './resolver.js'
import { ClearingDataSource }  from './datasource/settlement.js' 

// Expressサーバとの統合
const app = express();


// Expressサーバーへの受信リクエストを処理するhttpServerの設定
const httpServer = http.createServer(app);

// ApolloServer 初期化用の処理
const server = new ApolloServer({
  typeDefs,
  resolvers,
});

// ApolloServerの起動
await server.start()

// サーバーをマウントするパスの指定
app.use(
    '/graphql',
    cors(),
    bodyParser.json(),
    expressMiddleware(server, {
        context: async ({req}) => {
            return {
                dataSources: {
                    clearingApi: new ClearingDataSource()
                }
            }
        }
    }),
);

app.listen(4000)

console.log(`🚀 Server ready at http://localhost:4000/`);

app.get('/health', (req, res) => {
    res.status(200).send('Okay!');
});
