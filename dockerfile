# First Stage
FROM python:3.8 AS builder 
COPY requirments.txt .

#install dep. to local user directory
RUN pip install --user -r requirments.txt

#Second stage
FROM python:3.8-slim
WORKDIR /code

 # copy only the dependencies installation from the 1st stage image
COPY --from=builder /root/.local/bin /root/.local
COPY ./src .
# update PATH environment variable
ENV PATH=/root/.local:$PATH

CMD [ "python3", "./server.py" ] 
