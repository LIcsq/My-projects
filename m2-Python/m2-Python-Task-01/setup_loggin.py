import logging

def setup_logging(verbosity):
    """
    Set up logging based on the verbosity level.

    :param verbosity: Verbosity level (1-3).
    """
    if verbosity == 1:
        level = logging.WARNING
    elif verbosity == 2:
        level = logging.INFO
    elif verbosity == 3:
        level = logging.DEBUG
    else:
        level = logging.ERROR

    logging.basicConfig(
        level=level,
        format='%(asctime)s - %(levelname)s - %(message)s',
    )