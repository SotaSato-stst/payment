package main

import (
	"log"
	"os"

	amqp "github.com/rabbitmq/amqp091-go"
)

// エラーをチェックするヘルパー関数
func failOnError(err error, msg string) {
	if err != nil {
		log.Panicf("%s: %s", msg, err)
	}
}

func main() {
	// RabbitMQ サーバーに接続
	rabbitmqUri := os.Getenv("RABBITMQ")
	if rabbitmqUri == "" {
		rabbitmqUri = "amqp://guest:guest@localhost:5672/"
	}
	// RabbitMQ サーバーに接続
	conn, err := amqp.Dial(rabbitmqUri)

	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	// チャネルを開く
	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	// キューの宣言
	q, err := ch.QueueDeclare(
		"balance", // name
		false,     // durable
		false,     // delete when unused
		false,     // exclusive
		false,     // no-wait
		nil,       // arguments
	)
	failOnError(err, "Failed to declare a queue")

	// キューからメッセージを読み取るように指示
	msgs, err := ch.Consume(
		q.Name, // queue
		"",     // consumer
		true,   // auto-ack
		false,  // exclusive
		false,  // no-local
		false,  // no-wait
		nil,    // args
	)
	failOnError(err, "Failed to register a consumer")

	// ゴルーチン内でメッセージの読み取り
	var forever chan struct{}

	go func() {
		for d := range msgs {
			log.Printf("Received a message: %s", d.Body)
		}
	}()

	log.Printf(" [*] Waiting for messages. To exit press CTRL+C")
	<-forever
}
