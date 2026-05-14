import logging
import sys

def _setup_logger() -> logging.Logger:
    log = logging.getLogger("smart_notes")
    log.setLevel(logging.DEBUG)

    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(logging.DEBUG)

    formatter = logging.Formatter(
        fmt="%(asctime)s | %(levelname)-8s | %(name)s | %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    handler.setFormatter(formatter)

    if not log.handlers:
        log.addHandler(handler)

    return log


logger = _setup_logger()