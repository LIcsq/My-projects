import logging


def setup_logging(verbosity, log_file=None):
    """
    Set up logging based on the verbosity level and optional log file.

    :param verbosity: Verbosity level (1, 2, 3).
    :param log_file: Optional file to log to.
    """
    level = {
        1: logging.WARNING,
        2: logging.INFO,
        3: logging.DEBUG
    }.get(verbosity, logging.WARNING)

    if log_file:
        logging.basicConfig(filename=log_file, level=level, format='%(asctime)s - %(levelname)s - %(message)s')
    else:
        logging.basicConfig(level=level, format='%(asctime)s - %(levelname)s - %(message)s')
