//
//  AudioPlayer.swift
//  millionaire


import AVFoundation

class AudioPlayer {
    
    var player: AVAudioPlayer?
    
    func play(sound: String) {
       
        //Создаём константу с путем к аудиофайлу
        let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
        
        //Безопасно распаковываем url
        guard let soundURL = url else {return}
        
        //Безопасно создаём плеер
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Audio playback error")
        }
        
        //Пройгрываем медиа файл
        player?.play()
    }
}

