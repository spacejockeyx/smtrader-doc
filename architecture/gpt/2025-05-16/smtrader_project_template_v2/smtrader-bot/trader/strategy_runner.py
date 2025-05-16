import pandas as pd

def start_strategy():
    df = pd.read_csv("data/sample_data.csv")
    signals = []

    for idx, row in df.iterrows():
        if row['close'] > row['open']:
            signals.append((row['timestamp'], "BUY"))
        else:
            signals.append((row['timestamp'], "SELL"))

    return signals