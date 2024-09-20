import sys
from confluent_kafka import Producer, Consumer
from confluent_kafka.admin import AdminClient, NewTopic
import socket
from robot.libraries.BuiltIn import BuiltIn

#Disegno la finestra principale
def scriviMessaggi():
    print("Ciao mondo")
    args = len(sys.argv) - 1
    parametro=sys.argv[1].split("=")[0]
    valore = sys.argv[1].split("=")[1]
    print("Parameter at position %i is %s" , valore)
    #while (args >= pos):
    #print("Parameter at position %i is %s" % (pos, sys.argv[pos]))
    #    pos = pos + 1
    p = Producer({'bootstrap.servers': 'localhost:19092'})
    for i in range(int(valore)):
        print("ciao mondo ",i)
        p.produce('mytopic', 'my message')



def creaTopic():
    print("Numero di parametri in input ", len(sys.argv))
    valore = sys.argv[0]
    print("Nome del topic su cui scrivere ", valore)
    topic = sys.argv[1].split("=")[1]
    print("Nome del topic su cui scrivere ", topic)
    valore = sys.argv[2].split("=")[1]
    print("Parameter at position %i is %s", valore)
    p = Producer({'bootstrap.servers': 'localhost:19092'})
    p.produce(topic, '')
    p.poll(0)
    p.flush()


def scriviMessaggio():
    print("Numero di parametri in input ", len(sys.argv))
    valore = sys.argv[0]
    print("Nome del topic su cui scrivere ", valore)
    topic = sys.argv[1].split("=")[1]
    print("Nome del topic su cui scrivere ",topic)
    numMessaggi = sys.argv[2].split("=")[1]
    print("Parameter at position %i is %s", valore)
    valore = sys.argv[3].split("=")[1]
    print("messaggio riccevo ",valore)
    p = Producer({'bootstrap.servers': 'localhost:19092'})
    for i in range(int(numMessaggi)):
        p.produce(topic, value=valore)
        p.poll(0)
        p.flush()

#python kafka.py topic=TopicProva4 numMessaggi=10000 messaggio='{\"chiave\":\"valore\"}'

def provaKafka(topic,numeroMessaggi,messaggio):
    BuiltIn().log_to_console("sto qua 1")
    BuiltIn().log_to_console(topic)
    BuiltIn().log_to_console(numeroMessaggi)
    BuiltIn().log_to_console(messaggio)
    p = Producer({'bootstrap.servers': 'localhost:19092'})
    for i in range(int(numeroMessaggi)):
        p.produce(topic, value=messaggio)
        p.poll(0)
        p.flush()

#if __name__ == "__main__":
#    scriviMessaggio()
    #creaTopic()