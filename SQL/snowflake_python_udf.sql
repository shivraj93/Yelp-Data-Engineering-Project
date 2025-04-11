
-- Creating a user-defined function 'analyze_sentiment' to evaluate sentiment polarity of review text.
-- This Python-based function uses the 'textblob' library to classify the input text as Positive, Neutral, or Negative
-- based on the sentiment polarity score.


CREATE OR REPLACE FUNCTION analyze_sentiment(text string)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('textblob')
HANDLER = 'sentiment_analyzer'
AS $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity > 0:
        return 'Positive'
    elif analysis.sentiment.polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;