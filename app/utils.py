import uuid
from passlib.context import CryptContext
from google.cloud import translate
from openai import OpenAI
import re

# from config import settings

client = OpenAI(api_key = "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")

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def gen_uuid():
    return uuid.uuid4()


def hash_pass(password: str):
    return pwd_context.hash(password)


def verify(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def translate_text(text, type):
    text = str(text)
    # if type == "q":
    #     paraphrased_text = openai.ChatCompletion.create(
    #         model="gpt-3.5-turbo",
    #         messages=[
    #             {"role": "system", "content": f"Paraphrase the following text to make it sound like you are asking a question: {text}"}]
    #     )
    # elif type == "a":
    #     paraphrased_text = openai.ChatCompletion.create(
    #         model="gpt-3.5-turbo",
    #         messages=[
    #             {"role": "system", "content": f"Paraphrase the following text to make it sound like you are giving an answer to an asked question:: {text}"}]
    #     )
    # elif type == "s":
    #     paraphrased_text = openai.ChatCompletion.create(
    #         model="gpt-3.5-turbo",
    #         messages=[
    #             {"role": "system", "content": f"Paraphrase the following text to make it sound like you are suggesting an action: {text}"}]
    #     )
    # else:
    #     paraphrased_text = text
    project_id = "cheers-wisdom-translate"
    client = translate.TranslationServiceClient()
    location = "global"
    parent = f"projects/{project_id}/locations/{location}"
    # response=client.translate_text(
    #     request={
    #         "parent": parent,
    #         "contents": [text],
    #         "mime_type": "text/plain",
    #         "source_language_code": "en-US",
    #         "target_language_code": "hi",
    #     }
    # )
    # return response.translations[0].translated_text


def is_english(word):
    reg = re.compile(r'[a-zA-Z]')

    if reg.match(word):
        return True
    else:
        return False

def summarize(text):
    from openai import OpenAI
    response = client.chat.completions.create(
    model="gpt-4",
    messages=[
        {"role": "system", "content": "Summarize the following chat between a User and a Health Chatbot into a single paragraph to send it to the user's doctor so that he knows what the user's issue is."},
        {"role": "user", "content": text}
    ])
    return response.choices[0].message.content.strip()