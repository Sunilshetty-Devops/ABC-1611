FROM ubuntu:latest AS base

# Install cron and other necessary utilities
RUN apt-get update && apt-get install -y cron

# Create 'abc' user
RUN useradd -m abc

# Create the specific folder and change owner to 'abc'
RUN mkdir -p /home/abc/script_folde  && chown abc:abc /home/abc/script_folde/
WORKDIR /abc
# Stage 2: Intermediate stage
FROM base AS intermediate

COPY --from=base /abc /home/abc/script_folde
WORKDIR /abc
# Copy the shell script into the container
COPY ./shell123.sh /home/abc/script_folde/

# Change the permissions to execute
RUN chmod +x /home/abc/script_folde/shell123.sh
# Setup cron job to run the script
RUN echo "0 * * * * abc /home/abc/script_folde/shell123.sh 0" >> /etc/cron.d/abc-cron
# Stage 3: Clean up stage
FROM intermediate AS cleanup

# Run the script as cron with 0 as input as abc user
RUN service cron start && sleep 10 && crontab /etc/cron.d/abc-cron

# Stage 4: Create stage
FROM cleanup AS final

# Run the script as cron with 1 as input as abc user
RUN echo "1 * * * * abc /home/abc/script_folde/shell123.sh 1" >> /etc/cron.d/abc-cron

# Start the cron service
CMD ["cron", "-f"]
