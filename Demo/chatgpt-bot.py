import openai
import gradio as gr
import time
from google.cloud import translate

openai.api_key = "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"


def translate_text(text, source="en-US", target="hi"):
    text = str(text)
    project_id = "cheers-wisdom-translate"
    client = translate.TranslationServiceClient()
    location = "global"
    parent = f"projects/{project_id}/locations/{location}"
    response = client.translate_text(
        request={
            "parent": parent,
            "contents": [text],
            "mime_type": "text/plain",
            "source_language_code": source,
            "target_language_code": target,
        }
    )
    return response.translations[0].translated_text


with gr.Blocks() as demo:
    global history
    history = (
        "The following is conversation between a user and \"SRM Med Bot\" who is an AI Medical Health Bot.\n"
        + "The chatbot is helpful, creative, clever, and very friendly.\n"
        + "User: "
    )

    msg = gr.Textbox(label="User Input")
    chatbot = gr.Chatbot()

    clear = gr.ClearButton([msg, chatbot])

    def respond(message, chat_history):
        global history
        history += f"{message}\nChatbot: "
        response = openai.Completion.create(
            model="text-davinci-002",
            prompt=history,
            temperature=0.9,
            max_tokens=150,
            top_p=1,
            frequency_penalty=0,
            presence_penalty=0.6,
            stop="bye",
        )

        bot_message = response.choices[0].text

        # bot_message = translate_text(bot_message, "en-US", "hi")
        # message = translate_text(message, "hi", "en-US")

        history += f"{bot_message}\nUser: "

        chat_history.append([message, bot_message])
        time.sleep(0.5)
        print(history)
        return "", chat_history

    msg.submit(respond, [msg, chatbot], [msg, chatbot])


demo.launch()
