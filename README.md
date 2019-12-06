# speech_processing
#Kaldi ASR scripts

#Ensure audio is correct format:

soxi file.wav

#If the audio is stereo with two channels, split the channels:

sox file.wav leftchannel.wav remix 1
sox file.wav rightchannel.wav remix 2

#Convert audio to to 16-bit 8khz mono waveform:

ffmpeg -i <file.in> -acodec pcm_s16le -ac 1 -ar 8000 <file.out>
