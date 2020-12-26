from flask import Flask, request, jsonify, Response, make_response
from  pytube import YouTube

app = Flask(__name__)

@app.route('/Youtube', methods=["POST"])
def youtube():
    youtube_link_request = request.get_json(force=False, silent=False, cache=True)
    youtube_link = youtube_link_request['link']
    yt = YouTube(youtube_link)
    views = yt.views
    thumbnail = yt.thumbnail_url
    streams_data = yt.streams
    streams = []
    for stream in streams_data:
        stream_info = stream
        streams.append(stream_info.type)
    return jsonify({"Data": "successful completed", "info": streams, "views": views,"thumbnail":thumbnail}), 200


if __name__ == "__main__":
    app.run(debug=True)