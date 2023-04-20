#!/usr/bin/env python

from setuptools import setup, find_packages

setup(
    name='stable-diffusion-webui',
    version='1.0rc1',
    # Modules to import from other scripts:
    packages=find_packages(),
    # Executables
    scripts=[
        "launch.py",
        "webui.py"
    ],
)
