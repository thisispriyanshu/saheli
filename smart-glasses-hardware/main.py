import cv2
import numpy as np
import bluetooth
import socket
import RPi.GPIO as GPIO
import os

# Initialize camera
cap = cv2.VideoCapture(0)

# Initialize Bluetooth socket
server_socket = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
server_socket.bind(("", bluetooth.PORT_ANY))
server_socket.listen(1)

# Initialize Wi-Fi socket
wifi_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
wifi_socket.bind(("", 12345))  # You can choose any available port
wifi_socket.listen(1)

# Initialize SOS button
SOS_BUTTON_PIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(SOS_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def send_sos_alert():
    # Code to send SOS alert to the app
    sos_message = "SOS ALERT!"
    client_sock.send(sos_message.encode())
    wifi_client.send(sos_message.encode())

# Function to play audio
def play_audio(audio_file):
    os.system("aplay " + audio_file)

# Accept Bluetooth connection
client_sock, address = server_socket.accept()
print("Accepted connection from", address)

# Accept Wi-Fi connection
wifi_client, wifi_address = wifi_socket.accept()
print("Accepted Wi-Fi connection from", wifi_address)

while True:
    # Capture video
    ret, frame = cap.read()
    # Convert frame to bytes
    frame_bytes = cv2.imencode('.jpg', frame)[1].tobytes()
    # Send frame bytes over Bluetooth
    client_sock.send(frame_bytes)
    # Send frame bytes over Wi-Fi
    wifi_client.send(frame_bytes)

    # Check for SOS button press
    if GPIO.input(SOS_BUTTON_PIN) == GPIO.LOW:
        send_sos_alert()

    # Receive audio from the app over Bluetooth
    audio_data = client_sock.recv(1024)
    # Play audio
    if audio_data:
        with open("received_audio.wav", "wb") as audio_file:
            audio_file.write(audio_data)
        play_audio("received_audio.wav")

    # Receive audio from the app over Wi-Fi
    audio_data_wifi = wifi_client.recv(1024)
    # Play audio
    if audio_data_wifi:
        with open("received_audio_wifi.wav", "wb") as audio_file:
            audio_file.write(audio_data_wifi)
        play_audio("received_audio_wifi.wav")

    # Code for other functionalities as per your requirements

# Release resources
cap.release()
server_socket.close()
wifi_socket.close()
client_sock.close()
wifi_client.close()
