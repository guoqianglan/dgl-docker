FROM cschranz/gpu-jupyter:latest

RUN pip install dgl-cu110 --no-cache-dir

RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter --no-build && \
    pip install jupyterlab_code_formatter --no-cache-dir && \  
    jupyter serverextension enable --py jupyterlab_code_formatter
RUN pip install black autopep8 isort --no-cache-dir

# install tools for package management
RUN pip install pyscaffold[all] --no-cache-dir

# build and clean up
RUN jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
